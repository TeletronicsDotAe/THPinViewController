
#import "THPinBottomButtonView.h"

@interface THPinBottomButtonView ()
@property (nonatomic, strong, readwrite) UIButton *deleteButton;
@property (nonatomic, strong, readwrite) UIButton *cancelButton;
@end

@implementation THPinBottomButtonView

#pragma mark - Private

- (UIButton *)buttonByAddingToView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [button setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel
                                            forAxis:UILayoutConstraintAxisHorizontal];
    
    [self addSubview:button];
    
    // center in superview
    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    return button;
}



#pragma mark - Layout

- (CGSize)intrinsicContentSize
{
    CGSize intrinsicSize;
    switch (self.state) {
        case THPinBottomButtonStateCancel:
            if (!self.disableCancel) {
                intrinsicSize = [self.cancelButton intrinsicContentSize];
            } else {
                intrinsicSize = [self.deleteButton intrinsicContentSize];
            }
            break;
        case THPinBottomButtonStateDelete:
            intrinsicSize = [self.deleteButton intrinsicContentSize];
            break;
        case THPinBottomButtonStateNone:
            NSLog(@"State none");
            intrinsicSize = CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
            break;
    }
    return intrinsicSize;
}



#pragma mark - Accessors

- (void)setState:(THPinBottomButtonState)state
{
    _state = state;
    switch (state) {
        case THPinBottomButtonStateCancel:
            self.deleteButton.hidden = !self.disableCancel;
            self.deleteButton.enabled = NO;
            self.cancelButton.hidden = self.disableCancel;
            break;
        case THPinBottomButtonStateDelete:
            self.deleteButton.hidden = NO;
            self.deleteButton.enabled = YES;
            self.cancelButton.hidden = YES;
            break;
        case THPinBottomButtonStateNone:
            self.deleteButton.hidden = YES;
            self.cancelButton.hidden = YES;
            break;
    }
    [self invalidateIntrinsicContentSize];
}

- (void)setDisableCancel:(BOOL)disableCancel
{
    _disableCancel = disableCancel;
    [self setState:self.state];
}




#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:self.class] pathForResource:@"THPinViewController"
                                                                                                   ofType:@"bundle"]];

        _deleteButton = [self buttonByAddingToView];
        [_deleteButton setTitle:NSLocalizedStringFromTableInBundle(@"delete_button_title", @"THPinViewController", bundle, nil)
                       forState:UIControlStateNormal];
        
        _cancelButton = [self buttonByAddingToView];
        [_cancelButton setTitle:NSLocalizedStringFromTableInBundle(@"cancel_button_title", @"THPinViewController", bundle, nil)
                       forState:UIControlStateNormal];
        self.state = THPinBottomButtonStateCancel;
    }
    return self;
}

@end

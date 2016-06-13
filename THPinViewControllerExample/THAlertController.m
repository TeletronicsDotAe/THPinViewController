//
//  AlertController.m
//  AlertController
//
//  Created by Dylan Bettermann on 6/23/15.
//  Copyright (c) 2015 Dylan Bettermann. All rights reserved.
//
//  See https://github.com/dbettermann/AlertController
//

#import "THAlertController.h"

@interface THAlertController ()

@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation THAlertController

- (UIWindow *)alertWindow {
    if (_alertWindow == nil) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _alertWindow.rootViewController = [UIViewController new];
        _alertWindow.windowLevel = UIWindowLevelAlert + 1;
    }
    return _alertWindow;
}

- (void)show {
    [self show:YES completion:nil];
}

- (void)show:(BOOL)animated {
    [self show:animated completion:nil];
}

- (void)show:(BOOL)animated completion:(void (^)(void))completion {
    [self.alertWindow makeKeyAndVisible];
    
    [self.alertWindow.rootViewController presentViewController:self animated:animated completion:completion];
}

@end

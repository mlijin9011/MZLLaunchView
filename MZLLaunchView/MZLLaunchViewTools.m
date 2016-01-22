//
//  MZLLaunchViewTools.m
//  MZLLaunchView
//
//  Created by LiJin on 16/1/22.
//  Copyright © 2016年 LiJin. All rights reserved.
//

#import "MZLLaunchViewTools.h"
#import "MZLLaunchStartViewController.h"
#import "MZLLaunchGuideViewController.h"

static UIWindow *startViewWindow = nil;
static UIWindow *guideViewWindow = nil;

@implementation MZLLaunchViewTools

//用来显示启动推广页和引导页的Window
+ (UIWindow *)startWindow {
    if (startViewWindow == nil) {
        startViewWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        startViewWindow.backgroundColor = [UIColor clearColor];
        startViewWindow.userInteractionEnabled = YES;
        startViewWindow.windowLevel = UIWindowLevelAlert + 10;
        startViewWindow.hidden = YES;
    }
    
    return startViewWindow;
}

+ (UIWindow *)guideWindow {
    if (guideViewWindow == nil) {
        guideViewWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        guideViewWindow.backgroundColor = [UIColor clearColor];
        guideViewWindow.userInteractionEnabled = YES;
        guideViewWindow.windowLevel = UIWindowLevelAlert + 9;
        guideViewWindow.hidden = YES;
    }
    
    return guideViewWindow;
}

//显示启动推广页
+ (void)showLaunchStartView:(UIImage *)image {
    [self showLaunchStartView:image hideAfterDelay:3];
}

+ (void)showLaunchStartView:(UIImage *)image hideAfterDelay:(NSTimeInterval)delay {
    [self showLaunchStartView:image hideAfterDelay:delay withTimer:NO];
}

+ (void)showLaunchStartView:(UIImage *)image hideAfterDelay:(NSTimeInterval)delay withTimer:(BOOL)show {
    MZLLaunchStartViewController *startViewController = [[MZLLaunchStartViewController alloc] init];
    startViewController.imageView.image = image;
    [self startWindow].rootViewController = startViewController;
    [self startWindow].hidden = NO;
    
    startViewController.containerView.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
        startViewController.containerView.alpha = 1;
    } completion:^(BOOL finished) {
        if (show) {
            [startViewController showCountDownTimer:show timer:delay];
        } else if (delay > 0) {
            [self hideLaunchStartView:YES afterDelay:delay];
        }
    }];
}

//隐藏推广页
+ (void)hideLaunchStartView:(BOOL)animated {
    [self hideLaunchStartView:animated afterDelay:0];
}

+ (void)hideLaunchStartView:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    if (animated) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIView *rootView = [self startWindow].rootViewController.view;
            if (rootView) {
                [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
                    rootView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                    rootView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self clearStart];
                }];
            }
        });
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self clearStart];
        });
    }
}

//显示引导页
+ (void)showLaunchGuideView:(NSArray *)images withSkip:(BOOL)skip {
    MZLLaunchGuideViewController *guideViewController = [[MZLLaunchGuideViewController alloc] init];
    guideViewController.images = images;
    guideViewController.showSkip = skip;
    [self guideWindow].rootViewController = guideViewController;
    [self guideWindow].hidden = NO;
}

//隐藏引导页
+ (void)hideLaunchGuideView:(BOOL)animated {
    if (animated) {
        UIView *rootView = [self guideWindow].rootViewController.view;
        if (rootView) {
            [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
                [rootView setAlpha:0];
            } completion:^(BOOL finished) {
                [self clearGuide];
            }];
        }
    } else {
        [self clearGuide];
    }
}

//清理
+ (void)clearStart {
    if (startViewWindow) {
        startViewWindow.userInteractionEnabled = NO; //iOS7才需要这行代码,iOS7的UIAlertView在show以后会持有显示在最上层的Window.在这种情况下,只能等UIAlertView释放,这里才会自动释放
        [startViewWindow removeFromSuperview];
        startViewWindow = nil;
    }
}

+ (void)clearGuide {
    if (guideViewWindow) {
        guideViewWindow.userInteractionEnabled = NO; //iOS7才需要这行代码,iOS7的UIAlertView在show以后会持有显示在最上层的Window.在这种情况下,只能等UIAlertView释放,这里才会自动释放
        [guideViewWindow removeFromSuperview];
        guideViewWindow = nil;
    }
}

@end

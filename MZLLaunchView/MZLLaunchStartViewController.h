//
//  MZLLaunchStartViewController.h
//  MZLLaunchView
//
//  Created by LiJin on 16/1/22.
//  Copyright © 2016年 LiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZLLaunchStartViewController : UIViewController

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *skipButton;

- (void)showCountDownTimer:(BOOL)show timer:(NSTimeInterval)timer;

@end

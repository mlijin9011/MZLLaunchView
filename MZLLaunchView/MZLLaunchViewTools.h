//
//  MZLLaunchViewTools.h
//  MZLLaunchView
//
//  Created by LiJin on 16/1/22.
//  Copyright © 2016年 LiJin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MZLLaunchViewTools : NSObject

//显示启动推广页
+ (void)showLaunchStartView:(UIImage *)image;
+ (void)showLaunchStartView:(UIImage *)image hideAfterDelay:(NSTimeInterval)delay;
+ (void)showLaunchStartView:(UIImage *)image hideAfterDelay:(NSTimeInterval)delay withTimer:(BOOL)show;

//隐藏推广页
+ (void)hideLaunchStartView:(BOOL)animated;
+ (void)hideLaunchStartView:(BOOL)animated afterDelay:(NSTimeInterval)delay;

//显示引导页
+ (void)showLaunchGuideView:(NSArray *)images withSkip:(BOOL)skip hideDelegate:(id)delegate;

//隐藏引导页
+ (void)hideLaunchGuideView:(BOOL)animated;

@end

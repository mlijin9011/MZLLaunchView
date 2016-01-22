//
//  MZLLaunchGuideViewController.h
//  MZLLaunchView
//
//  Created by LiJin on 16/1/22.
//  Copyright © 2016年 LiJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZLLaunchGuideViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *images;

@property (nonatomic) BOOL showSkip;

@end

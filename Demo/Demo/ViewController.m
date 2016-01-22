//
//  ViewController.m
//  Demo
//
//  Created by LiJin on 16/1/22.
//  Copyright © 2016年 LiJin. All rights reserved.
//

#import "ViewController.h"
#import "MZLLaunchViewTools.h"
#import "MZLLaunchGuideViewController.h"

@interface ViewController () <MZLLaunchGuideViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MZLLaunchViewTools showLaunchStartView:[UIImage imageNamed:@"launch_start_image"] hideAfterDelay:3 withTimer:YES];
    [MZLLaunchViewTools showLaunchGuideView:@[[UIImage imageNamed:@"guide_image"], [UIImage imageNamed:@"guide_image"], [UIImage imageNamed:@"guide_image"]] withSkip:YES hideDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didHideGuideView {
    
}

@end

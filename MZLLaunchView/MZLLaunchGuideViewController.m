//
//  MZLLaunchGuideViewController.m
//  MZLLaunchView
//
//  Created by LiJin on 16/1/22.
//  Copyright © 2016年 LiJin. All rights reserved.
//

#import "MZLLaunchGuideViewController.h"
#import "MZLLaunchViewTools.h"

@interface MZLLaunchGuideViewController ()

@end

@implementation MZLLaunchGuideViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self.view addSubview:self.scrollView];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if (_images) {
        _images = nil;
    }
}

- (void)hideGuideView {
    [MZLLaunchViewTools hideLaunchGuideView:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHideGuideView)]) {
        [self.delegate didHideGuideView];
    }
    if (_images) {
        _images = nil;
    }
}

- (void)setImages:(NSArray *)images {
    _images = images;
    NSInteger count = images.count;
    for (NSInteger i = 0; i < count; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = images[i];
        imageView.tag = 1000 + i;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        if (i < count - 1) {
            UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.size.width - 15 - 60, 20, 60, 30)];
            skipButton.layer.cornerRadius = 15;
            skipButton.layer.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor;
            skipButton.layer.borderWidth = 1;
            skipButton.layer.masksToBounds = YES;
            skipButton.backgroundColor = [UIColor whiteColor];
            skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
            [skipButton setTitleColor:[UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1] forState:UIControlStateNormal];
            [skipButton addTarget:self action:@selector(hideGuideView) forControlEvents:UIControlEventTouchUpInside];
            skipButton.hidden = YES;
            skipButton.tag = 2000 + i;
            [imageView addSubview:skipButton];
        } else {
            CGSize size = CGSizeMake(100, 40);
            CGFloat centerX = self.scrollView.center.x;
            CGFloat centerY = imageView.frame.size.height - size.height * 2;
            
            UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(centerX - size.width/2, centerY - size.height/2, size.width, size.height)];
            startButton.layer.cornerRadius = 5;
            startButton.layer.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor;
            startButton.layer.borderWidth = 1;
            startButton.layer.masksToBounds = YES;
            startButton.backgroundColor = [UIColor whiteColor];
            startButton.titleLabel.font = [UIFont systemFontOfSize:17];
            [startButton setTitle:@"开始" forState:UIControlStateNormal];
            [startButton setTitleColor:[UIColor colorWithRed:226/255.0 green:101/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
            [startButton addTarget:self action:@selector(hideGuideView) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:startButton];
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
}

- (void)setShowSkip:(BOOL)showSkip {
    if (showSkip) {
        NSInteger count = _images.count;
        for (NSInteger i = 0; i < count - 1; ++i) {
            UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:1000 + i];
            UIButton *skipButton = (UIButton *)[imageView viewWithTag:2000 + i];
            skipButton.hidden = NO;
        }
    }
}

@end

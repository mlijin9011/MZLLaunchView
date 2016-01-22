//
//  MZLLaunchStartViewController.m
//  MZLLaunchView
//
//  Created by LiJin on 16/1/22.
//  Copyright © 2016年 LiJin. All rights reserved.
//

#import "MZLLaunchStartViewController.h"
#import "MZLLaunchViewTools.h"

@interface MZLLaunchStartViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic) NSInteger timeCount;

@end

@implementation MZLLaunchStartViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        backgroundView.image = [UIImage imageNamed:[self getDefaultLaunchImage]];
        [self.view addSubview:backgroundView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat logoHeight = screenWidth/320.0f * 100;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            logoHeight = screenWidth/768.0f * 180;
        }
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - logoHeight)];
        self.containerView.backgroundColor = [UIColor clearColor];
        self.containerView.clipsToBounds = YES;
        [self.view addSubview:self.containerView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.containerView.bounds];
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.containerView addSubview:self.imageView];
        
        self.skipButton = [[UIButton alloc] initWithFrame:CGRectMake(self.containerView.frame.size.width - 15 - 50, 20, 50, 20)];
        self.skipButton.layer.cornerRadius = 2;
        self.skipButton.layer.masksToBounds = YES;
        self.skipButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.skipButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.skipButton addTarget:self action:@selector(hideStartView) forControlEvents:UIControlEventTouchUpInside];
        self.skipButton.hidden = YES;
        [self.containerView addSubview:self.skipButton];
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
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)hideStartView {
    [MZLLaunchViewTools hideLaunchStartView:YES];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)showCountDownTimer:(BOOL)show timer:(NSTimeInterval)timer {
    if (show) {
        self.skipButton.hidden = NO;
        _timeCount = timer;
        [self refreshTimer];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTimer) userInfo:nil repeats:YES];
    }
}

- (void)refreshTimer {
    if (_timeCount > 0) {
        [self.skipButton setTitle:[NSString stringWithFormat:@"%d 跳过", (int)_timeCount] forState:UIControlStateNormal];
        _timeCount--;
    } else {
        [self hideStartView];
    }
}

- (NSString *)getDefaultLaunchImage {
    CGSize viewSize = self.view.bounds.size;
    
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [@"Portrait" isEqualToString:dict[@"UILaunchImageOrientation"]])
            return dict[@"UILaunchImageName"];
    }
    
    return nil;
}

@end

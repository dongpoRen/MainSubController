//
//  ViewController.m
//  主子控制器
//
//  Created by SuShi on 2020/2/24.
//  Copyright © 2020 SuShi. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MainSubDefine.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define MinOffsetY -100
#define MaxOffsetY -20
#define DeltaOffsetY 80

@interface ViewController ()
<
ViewControllerScrollDelegate
>

@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupView];
    
    [self addChildView];
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.blueView];
    [self.view insertSubview:self.contentScrollView belowSubview:self.blueView];
}

- (void)addChildView {
    
    OneViewController *oneVC = [[OneViewController alloc] init];
    oneVC.scrollViewDelegate = self;
    [self.contentScrollView addSubview:oneVC.view];
    [self addChildViewController:oneVC];
    
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    twoVC.scrollViewDelegate = self;
    twoVC.view.mj_x = self.view.mj_w;
    [self.contentScrollView addSubview:twoVC.view];
    [self addChildViewController:twoVC];

    ThreeViewController *threeVC = [[ThreeViewController alloc] init];
    threeVC.scrollViewDelegate = self;
    threeVC.view.mj_x = self.view.mj_w * 2;
    [self.contentScrollView addSubview:threeVC.view];
    [self addChildViewController:threeVC];
    
    self.viewControllers = @[oneVC, twoVC, threeVC];
}

#pragma mark - ViewControllerScrollDelegate

- (void)childScrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f", offsetY);

    if (offsetY <= MinOffsetY && self.blueView.mj_y != 0) {
        self.blueView.mj_y = 0;
        return;
    }
    
    if (offsetY >= MaxOffsetY && self.blueView.mj_y != -DeltaOffsetY) {
        self.blueView.mj_y = -DeltaOffsetY;
        return;
    }

    CGFloat delta = offsetY - MinOffsetY;
    if (delta > 0 && delta < DeltaOffsetY) {
        self.blueView.mj_y = -delta;
    }
    
    if (offsetY <= MaxOffsetY) {
        for (id<UIViewControllerProtocol> vc in self.viewControllers) {
            [vc updateContentOffset:scrollView.contentOffset];
        }
    } else if (offsetY > MaxOffsetY) {
        for (id<UIViewControllerProtocol> vc in self.viewControllers) {
            if ([vc getContentOffsetY] < MaxOffsetY) {
                [vc updateContentOffset:CGPointMake(0, MaxOffsetY)];
            }
        }
    }
}


#pragma mark - UIScrollViewDelegate


#pragma mark - Lazy load

- (UIView *)blueView {
    
    if (!_blueView) {
        _blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

- (UIScrollView *)contentScrollView {
    
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _contentScrollView.backgroundColor = [UIColor orangeColor];
        _contentScrollView.contentSize = CGSizeMake(self.view.mj_w * 3, 0);
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
//        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}


@end

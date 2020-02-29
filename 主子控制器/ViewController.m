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
#import "MainSubDefine.h"

@interface ViewController ()
<
ViewControllerScrollDelegate
>

@property (nonatomic, strong) UIView *purpleView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

@property (nonatomic, assign) CGFloat lastOffsetY;
@property (nonatomic, assign) CGFloat previewOffsetY;

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
    [self.blueView addSubview:self.purpleView];
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
    
    self.viewControllers = @[twoVC, threeVC];
}

#pragma mark - ViewControllerScrollDelegate

- (void)childScrollViewDidScrollWithContentOffsetY:(CGFloat)offsetY {

    NSLog(@"%f", offsetY);
    
    BOOL isUp = NO;
    
    if (offsetY > _lastOffsetY) {
        isUp = YES;
    } else {
        isUp = NO;
    }
    
    if (offsetY <= MinOffsetY && self.blueView.mj_y != 0) {
        self.blueView.mj_y = 0;
    }

    if (offsetY >= MaxOffsetY && self.blueView.mj_y != -DeltaOffsetY) {
        self.blueView.mj_y = -DeltaOffsetY;
    }

    CGFloat delta = offsetY - MinOffsetY;
    if (delta > 0 && delta < DeltaOffsetY) {
        self.blueView.mj_y = -delta;
    }

    if (offsetY <= MaxOffsetY) {
        for (id<UIViewControllerProtocol> vc in self.viewControllers) {
            if ([vc getContentOffsetY] > MaxOffsetY) return;
            [vc updateContentOffset:CGPointMake(0, offsetY)];
        }
    } else if (offsetY > MaxOffsetY) {
        for (id<UIViewControllerProtocol> vc in self.viewControllers) {
            if ([vc getContentOffsetY] < MaxOffsetY) {
                [vc updateContentOffset:CGPointMake(0, MaxOffsetY)];
            }
        }
    }
    
    _lastOffsetY = offsetY;
}

- (void)childScrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"开始拖拽%f", offsetY);
    _previewOffsetY = offsetY;
    _lastOffsetY = offsetY;
}


#pragma mark - Lazy load

- (UIView *)blueView {
    
    if (!_blueView) {
        _blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

- (UIView *)purpleView {
    
    if(!_purpleView) {
        _purpleView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenWidth, 20)];
        _purpleView.backgroundColor = [UIColor purpleColor];
    }
    return _purpleView;
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

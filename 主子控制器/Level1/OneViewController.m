//
//  OneViewController.m
//  主子控制器
//
//  Created by SuShi on 2020/2/24.
//  Copyright © 2020 SuShi. All rights reserved.
//

#import "OneViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface OneViewController ()
<
ViewControllerScrollDelegate,
UIViewControllerProtocol
>

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

@property (nonatomic, strong) UIView *greenView;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self setupView];
    
    [self addChildView];
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];
    [self.view insertSubview:self.contentScrollView belowSubview:self.greenView];
}

- (void)addChildView {
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    leftVC.scrollViewDelegate = self;
    [self.contentScrollView addSubview:leftVC.view];
    [self addChildViewController:leftVC];
    
    RightViewController *rightVC = [[RightViewController alloc] init];
    rightVC.scrollViewDelegate = self;
    rightVC.view.mj_x = self.view.mj_w;
    [self.contentScrollView addSubview:rightVC.view];
    [self addChildViewController:rightVC];
        
    self.viewControllers = @[leftVC, rightVC];
}

#pragma mark - UIViewControllerDelegate

- (void)updateContentOffset:(CGPoint)offset {
    
    [self p_updateChildViewControllersWithContentOffsetY:offset.y];
}

- (CGFloat)getContentOffsetY {
    return 0;
}


#pragma mark - ViewControllerScrollDelegate

- (void)childScrollViewDidScrollWithContentOffsetY:(CGFloat)offsetY {
    
    CGFloat mapOffsetY = offsetY + 30;
    
    if ([self.scrollViewDelegate respondsToSelector:@selector(childScrollViewDidScrollWithContentOffsetY:)]) {
        [self.scrollViewDelegate childScrollViewDidScrollWithContentOffsetY:mapOffsetY];
    }
    
    [self p_updateChildViewControllersWithContentOffsetY:mapOffsetY];
}

- (void)p_updateChildViewControllersWithContentOffsetY:(CGFloat)offsetY {
    
    if (offsetY <= MinOffsetY && self.greenView.mj_y != 100) {
        self.greenView.mj_y = 100;
        return;
    }

    if (offsetY >= MaxOffsetY && self.greenView.mj_y != 20) {
        self.greenView.mj_y = 20;
        return;
    }

    CGFloat delta = offsetY - MinOffsetY;
    if (delta > 0 && delta < DeltaOffsetY) {
        self.greenView.mj_y = -delta + 100;
    }

    if (offsetY <= MaxOffsetY) {
        for (id<UIViewControllerProtocol> vc in self.viewControllers) {
            [vc updateContentOffset:CGPointMake(0, offsetY - 30)];
        }
    } else if (offsetY > MaxOffsetY) {
        for (id<UIViewControllerProtocol> vc in self.viewControllers) {
            if ([vc getContentOffsetY] + 30 < MaxOffsetY) {
                [vc updateContentOffset:CGPointMake(0, MaxOffsetY - 30)];
            }
        }
    }
}


#pragma mark - UIScrollViewDelegate


#pragma mark - Lazy load

- (UIView *)greenView {
    
    if (!_greenView) {
        _greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 30)];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}

- (UIScrollView *)contentScrollView {
    
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _contentScrollView.backgroundColor = [UIColor orangeColor];
        _contentScrollView.contentSize = CGSizeMake(self.view.mj_w * 2, 0);
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _contentScrollView;
}

@end

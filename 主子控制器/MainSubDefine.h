//
//  MainSubDefine.h
//  主子控制器
//
//  Created by SuShi on 2020/2/24.
//  Copyright © 2020 SuShi. All rights reserved.
//

#ifndef MainSubDefine_h
#define MainSubDefine_h

#import <MJRefresh/MJRefresh.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define MinOffsetY -100
#define MaxOffsetY -20
#define DeltaOffsetY 80



@protocol UIViewControllerProtocol <NSObject>

- (void)updateContentOffset:(CGPoint)offset;
- (CGFloat)getContentOffsetY;

@end

@protocol ViewControllerScrollDelegate <NSObject>

- (void)childScrollViewDidScrollWithContentOffsetY:(CGFloat)offsetY;

@optional
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end



#endif /* MainSubDefine_h */

//
//  MainSubDefine.h
//  主子控制器
//
//  Created by SuShi on 2020/2/24.
//  Copyright © 2020 SuShi. All rights reserved.
//

#ifndef MainSubDefine_h
#define MainSubDefine_h

@protocol UIViewControllerProtocol <NSObject>

- (void)updateContentOffset:(CGPoint)offset;
- (CGFloat)getContentOffsetY;

@end

@protocol ViewControllerScrollDelegate <NSObject>

- (void)childScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end



#endif /* MainSubDefine_h */

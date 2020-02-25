//
//  RightViewController.h
//  主子控制器
//
//  Created by SuShi on 2020/2/25.
//  Copyright © 2020 SuShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainSubDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface RightViewController : UIViewController

@property (nonatomic, weak) id<ViewControllerScrollDelegate> scrollViewDelegate;

@end

NS_ASSUME_NONNULL_END

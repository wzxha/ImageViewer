//
//  UIViewController+WZXTransitioning.h
//  WZXPrsentAnimations
//
//  Created by WzxJiang on 16/5/31.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXAnimation.h"
@interface UIViewController (WZXModalTransitioning)<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong)WZXAnimation * presentAnimation;
@property(nonatomic,strong)WZXAnimation * dismissAnimation;

// Add in toVC
- (void)wzx_presentAnimation:(WZXAnimation *)animation;

// Add in toVC
- (void)wzx_dismissAnimation:(WZXAnimation *)animation;

@end

//
//  UIViewController+WZXPushTransitioning.h
//  WZXPrsentAnimations
//
//  Created by WzxJiang on 16/6/1.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXAnimation.h"

@interface UIViewController (WZXPushTransitioning)<UINavigationControllerDelegate>


@property(nonatomic,strong)WZXAnimation * pushAnimation;
@property(nonatomic,strong)WZXAnimation * popAnimation;

// Add in fromVC
- (void)wzx_pushAnimation:(WZXAnimation *)animation;

// Add in toVC
- (void)wzx_popAnimation:(WZXAnimation *)animation;

@end

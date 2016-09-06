//
//  UIViewController+WZXTransitioning.m
//  WZXPrsentAnimations
//
//  Created by WzxJiang on 16/5/31.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "UIViewController+WZXModalTransitioning.h"
#import <objc/runtime.h>

@implementation UIViewController (WZXTransitioning)

static NSString * wzx_presentAniamtion_key = @"wzx_presentAniamtion_key";
static NSString * wzx_dismissAnimation_key = @"wzx_dismissAnimation_key";

- (void)setPresentAnimation:(WZXAnimation *)presentAnimation {
    objc_setAssociatedObject(self, &wzx_presentAniamtion_key, presentAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WZXAnimation *)presentAnimation {
    return objc_getAssociatedObject(self, &wzx_presentAniamtion_key);
}

- (void)setDismissAnimation:(WZXAnimation *)dismissAnimation {
    objc_setAssociatedObject(self, &wzx_dismissAnimation_key, dismissAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WZXAnimation *)dismissAnimation {
    return objc_getAssociatedObject(self, &wzx_dismissAnimation_key);
}

- (void)wzx_dismissAnimation:(WZXAnimation *)animation {
    self.dismissAnimation = animation;
    self.transitioningDelegate = self;
}

- (void)wzx_presentAnimation:(WZXAnimation *)animation {
    self.presentAnimation = animation;
    self.transitioningDelegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return (id<UIViewControllerAnimatedTransitioning>)self.dismissAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return (id<UIViewControllerAnimatedTransitioning>)self.presentAnimation;
}

@end

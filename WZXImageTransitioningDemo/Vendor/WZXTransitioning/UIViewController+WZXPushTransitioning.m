//
//  UIViewController+WZXPushTransitioning.m
//  WZXPrsentAnimations
//
//  Created by WzxJiang on 16/6/1.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "UIViewController+WZXPushTransitioning.h"
#import <objc/runtime.h>

@implementation UIViewController (WZXPushTransitioning)

static NSString * wzx_pushAniamtion_key = @"wzx_pushAniamtion_key";
static NSString * wzx_popAnimation_key = @"wzx_popAnimation_key";

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(viewWillAppear:);
        SEL swizzSel  = @selector(wzx_viewWillAppear:);
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

- (void)wzx_viewWillAppear:(BOOL)animated {
    [self wzx_viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)setPushAnimation:(WZXAnimation *)pushAnimation {
    objc_setAssociatedObject(self, &wzx_pushAniamtion_key, pushAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WZXAnimation *)pushAnimation {
    return objc_getAssociatedObject(self, &wzx_pushAniamtion_key);
}

- (void)setPopAnimation:(WZXAnimation *)popAnimation {
    objc_setAssociatedObject(self, &wzx_popAnimation_key, popAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WZXAnimation *)popAnimation {
    return objc_getAssociatedObject(self, &wzx_popAnimation_key);
}

- (void)wzx_pushAnimation:(WZXAnimation *)animation {
    self.pushAnimation = animation;
    self.navigationController.delegate = self;
}

- (void)wzx_popAnimation:(WZXAnimation *)animation {
    self.popAnimation = animation;
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return (id<UIViewControllerAnimatedTransitioning>)self.pushAnimation;
    } else if (operation == UINavigationControllerOperationPop){
        return (id<UIViewControllerAnimatedTransitioning>)self.popAnimation;
    } else {
        return nil;
    }
}
@end

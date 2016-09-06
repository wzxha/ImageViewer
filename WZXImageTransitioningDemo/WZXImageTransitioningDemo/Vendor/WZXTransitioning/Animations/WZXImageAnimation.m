//
//  WZXImageAnimation.m
//  WZXImage
//
//  Created by WzxJiang on 16/9/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "WZXImageAnimation.h"
#import "WZXImageViewController.h"

@implementation WZXImageAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //目的ViewController
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[WZXImageViewController class]]) {
        WZXImageViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        //起始ViewController
        UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        //添加toView到上下文
        [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
        
        toViewController.view.backgroundColor = [UIColor clearColor];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromViewController.view.alpha = 0;
            toViewController.view.backgroundColor = [UIColor blackColor];
            
        } completion:^(BOOL finished) {

            if ([toViewController respondsToSelector:NSSelectorFromString(@"showAnimation:")]) {
                [toViewController performSelector:NSSelectorFromString(@"showAnimation:") withObject:^(BOOL finished) {
                    fromViewController.view.alpha = 1;
                    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                }];
            }
        }];

    } else {
        UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        //起始ViewController
        WZXImageViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        //添加toView到上下文
        [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
        if ([fromViewController respondsToSelector:NSSelectorFromString(@"hideAnimation:")]) {
            [fromViewController performSelector:NSSelectorFromString(@"hideAnimation:") withObject:^(BOOL finished) {
                [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                    fromViewController.view.alpha = 0;
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                }];
            }];
        }
    }
}
#pragma clang diagnostic pop


@end

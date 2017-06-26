//
//  Animation.swift
//  ImageViewer
//
//  Created by wzxjiang on 2017/6/26.
//  Copyright © 2017年 wzxjiang. All rights reserved.
//

import UIKit

class Animation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: .to)
        
        if let imageViewController = toViewController as? ImageViewController {
            
            present(withTransitionContext: transitionContext,
                    fromViewController: transitionContext.viewController(forKey: .from),
                    toViewController: imageViewController)
            
        } else if let imageViewController = transitionContext.viewController(forKey: .from) as? ImageViewController {
            
            dismiss(withTransitionContext: transitionContext,
                    fromViewController: imageViewController,
                    toViewController: toViewController)
        }
    }
    
    private func present(withTransitionContext transitionContext: UIViewControllerContextTransitioning,
                         fromViewController: UIViewController?,
                         toViewController: ImageViewController) {
        
        toViewController.view.backgroundColor = .clear
        
        transitionContext.containerView.addSubview(toViewController.view)
        
        toViewController.hideSelectedView()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.backgroundColor = .black
            
            toViewController.fullFrame()
            
        }) { transitionContext.completeTransition($0) }
    }
    
    private func dismiss(withTransitionContext transitionContext: UIViewControllerContextTransitioning,
                         fromViewController: ImageViewController,
                         toViewController: UIViewController?) {
    
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            fromViewController.view.backgroundColor = .clear
            
            fromViewController.resetFrame()
            
        }) {
            fromViewController.resetSelectedView()
            
            transitionContext.completeTransition($0)
        }
    }
}

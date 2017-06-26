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
        
        transitionContext.containerView.addSubview(toViewController.view)
        
        toViewController.view.backgroundColor = .clear
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.fullFrame()
            
            toViewController.view.backgroundColor = .black
            
        }) { (isFinished) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func dismiss(withTransitionContext transitionContext: UIViewControllerContextTransitioning,
                         fromViewController: ImageViewController,
                         toViewController: UIViewController?) {
    
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.backgroundColor = .clear
            
            fromViewController.resetFrame()
            
        }) { (isFinished) in
            transitionContext.completeTransition(true)
        }
    }
}

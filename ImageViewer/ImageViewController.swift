//
//  ImageViewController.swift
//  ImageViewer
//
//  Created by wzxjiang on 2017/6/26.
//  Copyright © 2017年 wzxjiang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    weak var selectedView: UIImageView? {
        didSet {
            guard var rect = selectedView?.frame else { return }
            
            guard let superView = selectedView?.superview,
                let window = UIApplication.shared.delegate?.window else { return }
            
            rect = superView.convert(rect, to: window)
            
            lastRect = rect
            
            createUI()
        }
    }
    
    fileprivate var lastRect: CGRect = .zero
    
    fileprivate var imageView: UIImageView?
    
    fileprivate var dismissY: CGFloat {
        return view.bounds.height/2.0 + 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUp()
    }
    
    private func setUp() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    fileprivate func createUI() {
        imageView = UIImageView(image: selectedView?.image)
        
        guard let imageView = imageView else { return }
        
        imageView.frame = lastRect
        
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(ImageViewController.pan(sender:))))
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageViewController.tap(sender:))))
    }
    
    @objc fileprivate func tap(sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @objc fileprivate func pan(sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: sender.view)
        
        if var center = sender.view?.center {
            center.x += point.x
            center.y += point.y
            
            var scale: CGFloat = 1.0
            
            if center.y > view.bounds.height/2.0 {
                scale = (view.bounds.height/2.0) / (center.y)
            }
            
            if var bounds = sender.view?.bounds {
                bounds.size.width = view.bounds.width * scale
                bounds.size.height = view.bounds.height * scale
                sender.view?.bounds = bounds
            }

            sender.view?.center = center

        }
        
        switch sender.state {
        case .ended:
            dismissJudge()
        default:
            break
        }
        
        sender.setTranslation(.zero, in: sender.view)
    }
    
    private func dismissJudge() {
        guard let imageView = imageView else { return }
        
        if imageView.center.y > dismissY {
            dismiss(animated: true)
        } else {
            fullFrame()
        }
    }
}

extension ImageViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animation()
    }
    
    func resetFrame(){
        guard let imageView = imageView else { return }
        
        imageView.frame = lastRect
    }
    
    func fullFrame(){
        guard let imageView = imageView else { return }
        
        imageView.frame = view.frame
    }
}

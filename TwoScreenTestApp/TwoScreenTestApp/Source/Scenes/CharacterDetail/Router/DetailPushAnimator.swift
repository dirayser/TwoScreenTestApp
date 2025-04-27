//
//  DetailPushAnimator.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 28.04.2025.
//

import UIKit

class DetailPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let toVC = transitionContext.viewController(forKey: .to) else {
      transitionContext.completeTransition(false)
      return
    }
    
    let containerView = transitionContext.containerView
    let finalFrame = transitionContext.finalFrame(for: toVC)
    
    toVC.view.frame = finalFrame
    toVC.view.transform = CGAffineTransform(translationX: containerView.bounds.width, y: 0)
    toVC.view.alpha = 0
    
    containerView.addSubview(toVC.view)
    
    UIView.animate(
      withDuration: transitionDuration(using: transitionContext),
      animations: {
        toVC.view.transform = .identity
        toVC.view.alpha = 1
      }, completion: { finished in
        transitionContext.completeTransition(finished)
      })
  }
}

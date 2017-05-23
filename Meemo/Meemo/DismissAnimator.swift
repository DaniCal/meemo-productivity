//
//  DismissAnimator.swift
//  Meemo
//
//  Created by Daniel Lohse on 4/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//



import UIKit

class DismissAnimator : NSObject {
    
}


extension DismissAnimator : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { fromVC.view.frame = finalFrame }, completion: { _ in transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
        
        
    }
    
}

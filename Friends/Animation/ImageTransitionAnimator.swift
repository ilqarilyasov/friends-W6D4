//
//  ImageTransitionAnimator.swift
//  Friends
//
//  Created by Ilgar Ilyasov on 10/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ImageTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var image: UIImage?
    var name: String?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? FriendsTableViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? DetailViewController,
            let toView = transitionContext.view(forKey: .to) else { return }
        
        // Create a container superview and set it's frame
        let containerView = transitionContext.containerView
        let fromViewEndFrame = transitionContext.finalFrame(for: toVC)
        containerView.addSubview(toView)
        toView.frame = fromViewEndFrame
        toView.alpha = 0.0
        
        // Get tapped cell from pretentedVC
        guard let indexPath = fromVC.tableView.indexPathForSelectedRow else { return }
            let fromCell = fromVC.tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        
        // Get image and label of the cell. Make the invisible
        guard let fromImage = fromCell.imageView,
            let fromName = fromCell.textLabel else { return }
        fromImage.alpha = 0.0
        fromName.alpha = 0.0
        
        // Get presentingVC's image and label. Make the invisible
        guard let toImage = toVC.image,
            let toName = toVC.name else { return }
        toImage.alpha = 0.0
        toName.alpha = 0.0
        
        // Replicate image and label. Add them to the containerview
        let imageInitialFrame = containerView.convert(fromImage.bounds, from: fromImage)
        let nameInitialFrame = containerView.convert(fromName.bounds, from: fromName)
        let animatedImage = UIImageView(frame: imageInitialFrame)
        let animatedName = UILabel(frame: nameInitialFrame)
        animatedImage.image = fromImage.image
        animatedName.text = fromName.text
        animatedName.font = fromName.font
        
        containerView.addSubview(animatedImage)
        containerView.addSubview(animatedName)
        
        let duration = transitionDuration(using: transitionContext)
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            let imageEndFrame = containerView.convert(toImage.bounds, from: toImage)
            let nameEndFrame = containerView.convert(toName.bounds, from: toName)
            animatedImage.frame = imageEndFrame
            animatedName.frame = nameEndFrame
            toView.alpha = 0.0
        }) { (_) in
            toImage.alpha = 1.0
            fromImage.alpha = 1.0
            toName.alpha = 1.0
            fromName.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
        
        
        
        
        
    }
    
    
    
    
}//end of class

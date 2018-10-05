//
//  ImageTransitionAnimator.swift
//  Friends
//
//  Created by Ilgar Ilyasov on 10/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ImageTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {
    
    private let duration: TimeInterval = 0.5
    var operation: UINavigationController.Operation = .push
    var image: UIImage?
    var name: String?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
        
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        guard let fromView = transitionContext.view(forKey: .from) as? FriendTableViewCell,
            let toVC = transitionContext.viewController(forKey: .to) as? DetailViewController,
            let toView = transitionContext.view(forKey: .to) else { return }

        // Create a container superview and set it's frame
        let containerView = transitionContext.containerView
        let fromViewEndFrame = transitionContext.finalFrame(for: toVC)
        containerView.addSubview(toView)
        toView.frame = fromViewEndFrame
        toView.alpha = 0.0


        // Get image and label of the cell. Make the invisible
        guard let fromImage = fromView.imageView,
            let fromName = fromView.name else { return }
        fromImage.alpha = 0.0
        fromName.alpha = 0.0

        // Get presentingVC's image and label. Make the invisible
        guard let toImage = toVC.friendImage,
            let toName = toVC.name else { return }
        toImage.alpha = 0.0
        toName.alpha = 0.0

        // Replicate image and label. Add them to the containerview
        let imageInitialFrame = containerView.convert(fromImage.bounds, from: fromImage)
        let nameInitialFrame = containerView.convert(fromName.bounds, from: fromName)
        let animatedImage = UIImageView(frame: imageInitialFrame)
        let animatedName = UILabel(frame: nameInitialFrame)
        animatedImage.image = fromImage.image
        animatedImage.contentMode = .scaleAspectFit
        animatedName.text = fromName.text
        animatedName.font = fromName.font

        containerView.addSubview(animatedImage)
        containerView.addSubview(animatedName)

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


/// DIFFERENT SOLUTION
//
//extension ImageTransitionAnimator {
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let presenting = operation == .push
//        let containerView = transitionContext.containerView
//
//        guard let toView = transitionContext.view(forKey: .to),
//            let fromView = transitionContext.view(forKey: .from) else { return }
//
//        let cellView = presenting ? fromView : toView
//        let cellDetailView = presenting ? toView : fromView
//
//        var initialFrame = presenting ? imageFrame : cellDetailView.frame
//        var finalFrame = presenting ? cellDetailView.frame : imageFrame
//
//        let initialAspectRatio = initialFrame.width / initialFrame.height
//        let cellDetailAspectRatio = cellDetailView.frame.width / cellDetailView.frame.height
//
//        if initialAspectRatio > cellDetailAspectRatio {
//            initialFrame.size = CGSize(width: initialFrame.height * cellDetailAspectRatio, height: initialFrame.height)
//        } else {
//            initialFrame.size = CGSize(width: initialFrame.width, height: initialFrame.width / cellDetailAspectRatio)
//        }
//
//        let finalFrameAspectRatio = finalFrame.width / finalFrame.height
//        var resizedFinalFrame = finalFrame
//
//        if finalFrameAspectRatio > cellDetailAspectRatio {
//            resizedFinalFrame.size = CGSize(width: finalFrame.height * cellDetailAspectRatio, height: finalFrame.height)
//        } else {
//            resizedFinalFrame.size = CGSize(width: finalFrame.width, height: finalFrame.width / cellDetailAspectRatio)
//        }
//
//        let scaleFactor = resizedFinalFrame.width / initialFrame.width
//        let growScaleFactor = presenting ? scaleFactor : 1 / scaleFactor
//        let shrinkScaleFactor = 1 / growScaleFactor
//
//        if presenting {
//            cellDetailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
//            cellDetailView.center = CGPoint(x: imageFrame.midX, y: imageFrame.midY)
//            cellDetailView.clipsToBounds = true
//        }
//
//        cellDetailView.alpha = presenting ? 0 : 1
//        cellView.alpha = presenting ? 1 : 0
//
//        containerView.addSubview(toView)
//        containerView.bringSubviewToFront(cellDetailView)
//
//        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
//            cellDetailView.alpha = presenting ? 1 : 0
//            cellView.alpha = presenting ? 0 : 1
//
//            if presenting {
//                let scale = CGAffineTransform(scaleX: growScaleFactor, y: growScaleFactor)
//                //let translat = CGAffineTransform.translatedBy()
//                let transform = CGAffineTransform(translationX: cellView.frame.midX - self.imageFrame.midX, y: cellView.frame.midY - self.imageFrame.midY)
//                //let translate = CGAffineTransformTranslate(cellView.transform, , )
//                cellView.transform = transform.concatenating(scale)
//                cellView.transform = .identity
//            } else {
//                cellView.transform = .identity
//                cellDetailView.transform = CGAffineTransform.init(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
//            }
//            cellDetailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
//        }) { (finished) in
//            transitionContext.completeTransition(finished)
//        }
//    }
//}

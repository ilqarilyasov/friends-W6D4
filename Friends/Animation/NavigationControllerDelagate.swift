//
//  NavigationControllerDelagate.swift
//  Friends
//
//  Created by Ilgar Ilyasov on 10/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//
//
import UIKit

class NavigationControllerDelagate: NSObject, UINavigationControllerDelegate {

    var sourceCell: UITableViewCell?
    var imageTransitionAnimator: ImageTransitionAnimator?

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            guard let cell = sourceCell else { return nil}
            guard let transitionImage = cell.imageView else { return nil }
            guard let transitionName = cell.textLabel else { return nil }
            
            imageTransitionAnimator = ImageTransitionAnimator()
            imageTransitionAnimator?.image = transitionImage.image
            imageTransitionAnimator?.name = transitionName.text
            
        }
        imageTransitionAnimator?.operation = operation
        return imageTransitionAnimator
    }

}//end of class

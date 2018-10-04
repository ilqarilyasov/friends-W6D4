//
//  NavigationControllerDelagate.swift
//  Friends
//
//  Created by Ilgar Ilyasov on 10/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class NavigationControllerDelagate: NSObject, UINavigationControllerDelegate {
    
    var sourceCell: UITableViewCell?
    let imageTransitionAnimator = ImageTransitionAnimator()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return imageTransitionAnimator
    }
    
    
    
    
}//end of class

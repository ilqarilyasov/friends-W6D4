//
//  CustomNavigationController.swift
//  Friends
//
//  Created by Ilgar Ilyasov on 10/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
// 1. Created a custom subclass
class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 2. Set the delgate of navigation controller to itself
        delegate = self
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // 3. We can use operation object to see if it's push or pop transition
        // So that the animation can be cutomized based on this
        if operation == .push {
            return ImageTransitionAnimator(presenting: true)
        } else {
            return ImageTransitionAnimator(presenting: false)
        }
    }
}

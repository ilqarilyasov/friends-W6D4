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
    
    // 4. First add this properties
    private var interactionController: UIPercentDrivenInteractiveTransition?
    private var edgeSwipeGestureRecognizer: UIScreenEdgePanGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 2. Set the delgate of navigation controller to itself
        delegate = self
        // 5. Configure the gesture recognizer in viewDidLoad()
        edgeSwipeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipe(_:))) // We'll add a handler
        edgeSwipeGestureRecognizer!.edges = .left
        view.addGestureRecognizer(edgeSwipeGestureRecognizer!)
    }
    
    // 6. Add the handler for the gesture recognizer
    @objc func handleSwipe(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        // 7. First we calculate how far the user has swiped
        let percent = gestureRecognizer.translation(in: gestureRecognizer.view!).x / gestureRecognizer.view!.bounds.size.width
        
        if gestureRecognizer.state == .began {
            // 8. If gesture just began, we create the interaction controller
            // Then begin the transition by calling popViewController(animated:)
            interactionController = UIPercentDrivenInteractiveTransition()
            popViewController(animated: true)
        } else if gestureRecognizer.state == .changed {
            // 9. When the progress changes, we call update(_:) on the interaction controller
            interactionController?.update(percent)
        } else if gestureRecognizer.state == .ended {
            // 10. When gesture is complete,
            // We tell the interaction controller to either finish the transition or cancel it
            // Finally we set the controller back to nil.
            // We simply return nil when a non-interaction transition is happening
            // And we also need to let iOS know to use this transition controller
            // This is done by impletenting another UINavigationControllerDelegate method
            // Namely navigation(_:interactionControllerFor:) -> 11.
            if percent > 0.5 && gestureRecognizer.state != .cancelled {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil
        }
    }
    
    // 11. Let's implement navigation(_:interactionControllerFor:)
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // 3. We can use operation object to see if it's push or pop transition
        // So that the animation can be cutomized based on this
        // That's great but swipe-back gesture no longer works
        // In order to make the transition interactive we need two additional things
        // 1 Something to drive the progress of the transition
        // 2 An interaction controller (an object conforming to UIViewControllerInteractiveTransitioning)
        // We are going to use UIGestureRecognizer
        // More specially a UIScreenEdgePanGestureRecognize to drive the transition -> 4.
        if operation == .push {
            return ImageTransitionAnimator(presenting: true)
        } else {
            return ImageTransitionAnimator(presenting: false)
        }
    }
}

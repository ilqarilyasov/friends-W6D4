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
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        <#code#>
    }
    
    
}

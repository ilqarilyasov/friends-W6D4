//
//  FriendsTableViewController.swift
//  Friends
//
//  Created by Ilgar Ilyasov on 10/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    let friendController = FriendController()
    var navigationControllerDelegate: NavigationControllerDelagate?
    var imageTransitionAnimator: ImageTransitionAnimator?
    var transitionImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = navigationControllerDelegate
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendController.friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendTableViewCell else { return UITableViewCell()}
        
        let friend = friendController.friends[indexPath.row]
        
        cell.friendImage.image = friend.friendImage
        cell.name.text = friend.name
        
        return cell
    }

    // MARK: - Animate the cell when scrolling
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let friend = friendController.friends[indexPath.row]
        
        if friend.hasShown == false {
            cell.alpha = 0.0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
            cell.layer.transform = transform
            UIView.animate(withDuration: 1.0) {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
            }
            friend.hasShown = true
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? FriendTableViewCell
        transitionImage = cell?.friendImage
        
        let detailVC = DetailViewController()
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSegue" {
            guard let destinationVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let friend = friendController.friends[indexPath.row]
            destinationVC.friend = friend
            navigationControllerDelegate?.sourceCell = tableView.cellForRow(at: indexPath)
        }
    }
}

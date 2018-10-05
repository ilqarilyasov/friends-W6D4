//
//  DetailViewController.swift
//  Friends
//
//  Created by Ilgar Ilyasov on 10/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let imageTransitionAnimator = ImageTransitionAnimator()
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UILabel!
    
    var friend: Friend? {
        didSet { updateViews() }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        
        guard let friend = friend, isViewLoaded else { return }
        
            friendImage.image = friend.friendImage
            name.text = friend.name
            bio.text = friend.bio
    }
}

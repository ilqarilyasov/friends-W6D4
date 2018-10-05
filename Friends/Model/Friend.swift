//
//  Friend.swift
//  Friends
//
//  Created by Ilgar Ilyasov on 10/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class Friend {
    
    let name: String
    let friendImage: UIImage
    let bio: String
    var hasShown: Bool // For cell scroll animation
    
    init(name: String, image: UIImage, bio: String, hasShown: Bool = false) {
        self.name = name
        self.friendImage = image
        self.bio = bio
        self.hasShown = hasShown
    }
    
}

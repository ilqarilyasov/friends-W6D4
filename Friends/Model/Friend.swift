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
    let image: UIImage
    let bio: String
    var hasShown: Bool // For cell animation
    
    init(name: String, image: UIImage, bio: String, hasShown: Bool = false) {
        self.name = name
        self.image = image
        self.bio = bio
        self.hasShown = hasShown
    }
    
}

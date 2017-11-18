//
//  Posts.swift
//  FirePhotos
//
//  Created by Dustin Pack on 9/10/17.
//  Copyright © 2017 Polemics Applications. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}

//
//  Collection.swift
//  ShopifyChallengeS2019
//
//  Created by Filip Matić on 2019-01-09.
//  Copyright © 2019 Filip Matić. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Collection {
    let id : String
    let title : String
    
    init(withDictionary collectionDictionary: JSON) {
        self.id = collectionDictionary["id"].stringValue
        self.title = collectionDictionary["title"].stringValue
    }
}

//
//  Product.swift
//  ShopifyChallengeS2019
//
//  Created by Filip Matić on 2019-01-09.
//  Copyright © 2019 Filip Matić. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Product {
    //product details we want
    let title : String
//    let totalAvailableInventory : Double
//    let collectionTitle : String
    let productImageURL : String
    
    init(withDictionary productDictionary: JSON) {
        self.title = productDictionary["title"].stringValue
//        self.totalAvailableInventory =
//        self.collectionTitle = productDictionary[""]
        self.productImageURL = productDictionary["image"]["src"].stringValue
    }
}

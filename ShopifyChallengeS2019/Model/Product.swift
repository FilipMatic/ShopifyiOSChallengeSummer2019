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
    let title : String
    let productId : String
    let productImageURL : String
    let vendor : String
    let type : String
    let tags : String
    let totalAvailableInventory : Int
    
    init(withDictionary productDictionary: JSON) {
        self.title = productDictionary["title"].stringValue
        self.productId = productDictionary["id"].stringValue
        self.productImageURL = productDictionary["image"]["src"].stringValue
        self.vendor = productDictionary["vendor"].stringValue
        self.type = productDictionary["product_type"].stringValue
        self.tags = productDictionary["tags"].stringValue
        
        var inventory = 0
        productDictionary["variants"].array?.forEach({ (variant) in
            let inventoryString = variant["inventory_quantity"].stringValue
            inventory += Int(inventoryString)!
        })
        self.totalAvailableInventory = inventory
    }
}

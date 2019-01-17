//
//  DataFetcher.swift
//  ShopifyChallengeS2019
//
//  Created by Filip Matić on 2019-01-09.
//  Copyright © 2019 Filip Matić. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataFetcher {
    
    static let shared = DataFetcher()
    
    func requestCollectionsData(completion: @escaping(_ collections: [Collection]?) -> Void) {
        let collectionsURL = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        var collections : [Collection] = []
        
        Alamofire.request(collectionsURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonObject = JSON(value)
                let customCollections = jsonObject["custom_collections"]
                
                customCollections.array?.forEach({ collection in
                    let collectionObject = Collection(withDictionary: collection)
                    collections.append(collectionObject)
                })
                completion(collections)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
        
    }
    
    func requestProductIds(collection: Collection, completion: @escaping(_ productIDs: [String]?) -> Void) {
        let collectionId = collection.id
        let productsURL = "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\(collectionId)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        var productIDs : [String] = []
        
        Alamofire.request(productsURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonObject = JSON(value)
                let collects = jsonObject["collects"]
                
                collects.array?.forEach({ product in
                    productIDs.append(product["product_id"].description)
                })
                completion(productIDs)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func requestProductsDetailsData(productIDs: [String], completion: @escaping(_ products: [Product]?) -> Void) {
        var products : [Product] = []
        var productIds = ""
        
        for productID in productIDs {
            productIds.append("\(productID),")
        }
        productIds.removeLast()
        print(productIds)
        
        let productsDetailsURL = "https://shopicruit.myshopify.com/admin/products.json?ids=\(productIds)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        
        Alamofire.request(productsDetailsURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonObject = JSON(value)
                let productsList = jsonObject["products"]
                
                productsList.array?.forEach({ product in
                    let productObject = Product(withDictionary: product)
                    products.append(productObject)
                })
                completion(products)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}

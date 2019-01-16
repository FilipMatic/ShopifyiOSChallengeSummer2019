//
//  ProductDetailsViewController.swift
//  ShopifyChallengeS2019
//
//  Created by Filip Matić on 2019-01-12.
//  Copyright © 2019 Filip Matić. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductDetailsViewController: UIViewController {
    
    var product : Product?
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = product?.title
        productTitleLabel.text = product?.title
        requestImage(productImageURL: (product?.productImageURL)!)
    }
    
    func requestImage(productImageURL: String) {
//        let url = productImageURL.replacingOccurrence
        let url = "https://cdn.shopify.com/s/files/1/1000/7970/products/Aerodynamic_20Concrete_20Clock.png?v=1443055734"
        
        Alamofire.request(url).responseImage { (response) in
            if let image = response.result.value {
                self.productImageView.image = image
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

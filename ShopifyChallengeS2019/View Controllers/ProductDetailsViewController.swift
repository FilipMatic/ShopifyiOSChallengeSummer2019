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
    
    // MARK: - Private Properties
    
    @IBOutlet private var productImageView: UIImageView!
    @IBOutlet private var inventoryLabel: UILabel!
    @IBOutlet private var productIDLabel: UILabel!
    @IBOutlet private var collectionLabel: UILabel!
    @IBOutlet private var vendorLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var tagsLabel: UILabel!
    @IBOutlet private var activityIndicatorView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public Properties
    
    var product : Product?
    var collectionTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInfo()
        navigationItem.title = product?.title
        inventoryLabel.text = String(describing: product!.totalAvailableInventory)
        requestImage(productImageURL: (product?.productImageURL)!)
    }
    
    // MARK: - Private Methods
    
    private func requestImage(productImageURL: String) {
        let url = productImageURL.replacingOccurrences(of: "\\", with: "")
        
        Alamofire.request(url).responseImage { (response) in
            if let image = response.result.value {
                self.productImageView.image = image
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        }
    }
    
    private func setInfo() {
        productIDLabel.text = "Product ID: \(product!.productId)"
        collectionLabel.text = "Collection: \(collectionTitle!)"
        vendorLabel.text = "Vendor: \(product!.vendor)"
        typeLabel.text = "Type: \(product!.type)"
        tagsLabel.text = "Tags: \(product!.tags)"
    }
}

//
//  ProductsViewController.swift
//  ShopifyChallengeS2019
//
//  Created by Filip Matić on 2019-01-12.
//  Copyright © 2019 Filip Matić. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Private Properties
    private var products: [Product] = []
    private var productIDs : [String] = []
    
    @IBOutlet var productsTableView: UITableView!
    @IBOutlet var activityIndicatorView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionDescriptionTextView: UITextView!
    @IBOutlet var collectionImageView: UIImageView!
    
    // MARK: - Public Properties
    
    var collection : Collection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Collection Details"
        navigationItem.largeTitleDisplayMode = .never
        collectionDescriptionTextView.text = collection?.bodyHTML == "" ? "Description unavailable" : collection?.bodyHTML
        requestImage(productImageURL: (collection?.imageURL)!)
        fetchProductsData()
        productsTableView.tableFooterView = UIView()
    }
    
    // MARK: - Private Methods
    
    private func fetchProductsData() {
        DataFetcher.shared.requestProductIds(collection: collection!) { productIds in
            productIds?.forEach({ productId in
                self.productIDs.append(productId)
            })
            DataFetcher.shared.requestProductsDetailsData(productIDs: self.productIDs) { products in
                products?.forEach({ product in
                    self.products.append(product)
                })
                DispatchQueue.main.async {
                    self.productsTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.activityIndicatorView.isHidden = true
                }
            }
        }
    }
    
    func requestImage(productImageURL: String) {
        let url = productImageURL.replacingOccurrences(of: "\\", with: "")
        
        Alamofire.request(url).responseImage { (response) in
            if let image = response.result.value {
                self.collectionImageView.image = image
            }
        }
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = products[indexPath.row].title
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "productDetailsSegue", sender: products[indexPath.row])
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailsViewController = segue.destination as! ProductDetailsViewController
        productDetailsViewController.product = sender as? Product
        productDetailsViewController.collectionTitle = collection?.title
    }
}

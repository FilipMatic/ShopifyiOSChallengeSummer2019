//
//  ProductsViewController.swift
//  ShopifyChallengeS2019
//
//  Created by Filip Matić on 2019-01-12.
//  Copyright © 2019 Filip Matić. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var collection : Collection?    
    var products: [Product] = []
    var productIDs : [String] = []

    @IBOutlet var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Collection Details"
        
        DataFetcher.shared.requestProductsData(collection: collection!) { (productIds) in
            productIds?.forEach({ (productId) in
                self.productIDs.append(productId)
                print(productId)
            })
            DataFetcher.shared.requestProductsDetailsData(productIDs: self.productIDs) { (products) in
                products?.forEach({ (product) in
                    self.products.append(product)
                    print(product.title)
                })
                self.productsTableView.reloadData()
            }
        }
        productsTableView.tableFooterView = UIView()
    }
    
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
        productDetailsViewController.product = sender as! Product
    }

}

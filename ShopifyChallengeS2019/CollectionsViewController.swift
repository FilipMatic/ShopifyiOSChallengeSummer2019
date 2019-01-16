//
//  CollectionsViewController.swift
//  ShopifyChallengeS2019
//
//  Created by Filip Matić on 2019-01-12.
//  Copyright © 2019 Filip Matić. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CollectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var collections: [Collection] = []
    
    @IBOutlet var collectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Custom Collections"
        
        DataFetcher.shared.requestCollectionsData { (collections) in
            collections?.forEach({ (collectionItem) in
                self.collections.append(collectionItem)
                print("\(collectionItem.id) & \(collectionItem.title)")
            })
            self.collectionsTableView.reloadData()
        }
        
        collectionsTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = collections[indexPath.row].title
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "productsSegue", sender: collections[indexPath.row])
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productsViewController = segue.destination as! ProductsViewController
        productsViewController.collection = sender as! Collection
    }

}

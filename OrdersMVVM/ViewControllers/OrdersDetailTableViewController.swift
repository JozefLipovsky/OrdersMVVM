//
//  OrdersDetailTableViewController.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-09-17.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit
import RealmSwift

class OrdersDetailTableViewController: UITableViewController {
    
    var user: User? {
        didSet {
//            self.navigationItem.title = user?.name
//            
//            if let user = user {
//                APIManager.downloadOrders(forUserID: user.id, completion: { (orders, error) in
//                    print(orders)
//                    print(error)
//                })
//            }
        }
    }
    
    var viewModel: OrdersDetailViewModel?
    var viewModelUpdateNotification: NotificationToken? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    
    // MARK: - Helpers
    
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        navigationItem.title = user?.name
    }
    
    
    private func configureViewModel() {
        guard let user = user else { return }
        
        viewModel = OrdersDetailViewModel(user)
        viewModelUpdateNotification = viewModel?.user?.orders.addNotificationBlock({ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .Initial, .Update:
                tableView.reloadData()
            case .Error(let error):
                print("OrdersViewModel update notification block error: \(error.localizedDescription)")
                break
            }
        })
    }
}

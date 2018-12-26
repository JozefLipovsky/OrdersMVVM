//
//  OrdersDetailTableViewController.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-09-17.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit
import RealmSwift


class OrdersDetailTableViewController: UITableViewController, AlertPresentable, EmptyBackgroundPresentable {
    @IBOutlet weak var pullToRefreshControl: UIRefreshControl!
    
    var user: User?
    var viewModel: OrdersDetailViewModel?
    var viewModelUpdateNotification: NotificationToken? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureViewModel()
        pullToRefresh(pullToRefreshControl)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            addEmptyBackground(withTitle: "No user selected.", subTitle: "Select user to see order details.")
            return 0
        }
        
        return viewModel.numberOfOrders()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel = viewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableCell", for: indexPath) as! OrderTableCell
            cell.configureWith(name: viewModel.nameOfOrder(at: indexPath.row), count: viewModel.countOfOrder(at: indexPath.row))
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OrdersDetailTableHeader") as! OrdersDetailTableHeader
        header.configureWith(title: "Phone", subTitle: viewModel.user.phone)
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel != nil else { return 0 }
        return 66.0
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    // MARK: - IBAction
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        guard let viewModel = viewModel else {
            sender.endRefreshing()
            return
        }
        
        removeEmptyBackgroundIfPresented()
        
        sender.beginRefreshing()
        viewModel.refreshData { [weak self] (persistedOrdersAvailable, error) in
            sender.endRefreshing()
            guard let strongSelf = self else { return }
            
            if let error = error, persistedOrdersAvailable == true {
                strongSelf.showAlert(title: "Error. Unable to refresh orders data at the moment.", message: error.localizedDescription)

            } else if let error = error, persistedOrdersAvailable == false {
                strongSelf.addEmptyBackground(withTitle: "Error. Orders details not available at the moment. \(error.localizedDescription)", subTitle: "Pull down to Refresh.")
                
            } else if error == nil, persistedOrdersAvailable == false {
                strongSelf.addEmptyBackground(withTitle: "No data available. Selected user have placed no orders.", subTitle: "Pull down to Refresh.")
            }
        }
    }
    
    
    // MARK: - Helpers
    
    fileprivate func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.register(UINib(nibName: "OrdersDetailTableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "OrdersDetailTableHeader")
        navigationItem.title = user?.name
        pullToRefreshControl.layoutIfNeeded()
    }
    
    
    fileprivate func configureViewModel() {
        guard let user = user else { return }
        
        viewModel = OrdersDetailViewModel(for: user)
        viewModelUpdateNotification = viewModel?.user.orders.observe({ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial, .update:
                tableView.reloadData()
                
            case .error(let error):
                print("OrdersViewModel update notification block error: \(error.localizedDescription)")
                break
            }
        })
    }
}



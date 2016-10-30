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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.numberOfOrders()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableCell", for: indexPath) as! OrderTableCell
        cell.configure(withName: (viewModel?.nameOfOrder(at: indexPath.row))!, count: (viewModel?.countOfOrder(at: indexPath.row))!)
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OrdersDetailTableHeader") as! OrdersDetailTableHeader
        header.configure(withTitle: "Phone", subTitle: viewModel.user.phone)
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
        
        sender.beginRefreshing()
        viewModel.refreshData { [weak self] (error) in
            sender.endRefreshing()
//            guard let strongSelf = self else { return }
//            strongSelf.updateTableBackground()
        }
    }
    
    
    // MARK: - Helpers
    
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.register(UINib(nibName: "OrdersDetailTableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "OrdersDetailTableHeader")
        navigationItem.title = user?.name
        pullToRefreshControl.layoutIfNeeded()
    }
    
    
    private func configureViewModel() {
        guard let user = user else { return }
        
        viewModel = OrdersDetailViewModel(user)
        viewModelUpdateNotification = viewModel?.user.orders.addNotificationBlock({ [weak self] (changes: RealmCollectionChange) in
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

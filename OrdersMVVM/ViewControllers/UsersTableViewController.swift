//
//  UsersTableViewController.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit
import RealmSwift

class UsersTableViewController: UITableViewController {
    @IBOutlet weak var pullToRefreshControl: UIRefreshControl!
    
    var viewModel: UsersViewModel!
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
        return viewModel.numberOfUsers()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as! UserTableCell
        cell.configure(withName: viewModel.nameOfUser(at: indexPath.row), phone: viewModel.phoneOfUser(at: indexPath.row), pictureURL: viewModel.pictureURLOfUser(at: indexPath.row))
        return cell
    }
    
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    

    // MARK: - IBAction
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        viewModel.refreshData {
            sender.endRefreshing()
        }
    }
    

    // MARK: - Helpers
    
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsMultipleSelection = false
        tableView.estimatedRowHeight = 60.0
        navigationItem.title = "Orders"
        pullToRefreshControl.layoutIfNeeded() // to fix https://openradar.appspot.com/27516269
    }
    
    
    private func configureViewModel()  {
        viewModel = UsersViewModel()
        viewModelUpdateNotification = viewModel.users?.addNotificationBlock({ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
                
            case .update:
                let selectedRowIndexPath = tableView.indexPathForSelectedRow
                tableView.reloadData()
                tableView.selectRow(at: selectedRowIndexPath, animated: false, scrollPosition: .none)
                
            case .error(let error):
                print("ViewModel update notification block error: \(error.localizedDescription)")
                break
            }
        })
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let odersDetailVC = (segue.destination as! UINavigationController).topViewController as! OrdersDetailTableViewController
                odersDetailVC.user = viewModel.user(at: indexPath.row)
            }
        }
    }
    
}

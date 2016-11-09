//
//  UsersTableViewController.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit
import RealmSwift

class UsersTableViewController: UITableViewController, AlertPresentable, EmptyBackgroundPresentable {
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
        cell.configureWith(name: viewModel.nameOfUser(at: indexPath.row), phone: viewModel.phoneOfUser(at: indexPath.row), pictureURL: viewModel.pictureURLOfUser(at: indexPath.row))
        return cell
    }
    
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    

    // MARK: - IBAction
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        removeEmptyBackgroundIfPresented()
        
        sender.beginRefreshing()
        viewModel.refreshData { [weak self] (persistedUsersAvailable, error) in
            sender.endRefreshing()
            guard let strongSelf = self else { return }
            
            if let error = error, persistedUsersAvailable == true {
                strongSelf.showAlert(title: "Error. Unable to refresh users data at the moment.", message: error.localizedDescription)
                
            } else if let error = error, persistedUsersAvailable == false {
                strongSelf.addEmptyBackground(withTitle: "Error. Users data not available at the moment. \(error.localizedDescription)", subTitle: "Pull down to Refresh.")
                
            } else if error == nil, persistedUsersAvailable == false {
                strongSelf.addEmptyBackground(withTitle: "No users available.", subTitle: "Pull down to Refresh.")
            }
        }
    }
    

    // MARK: - Helpers
    
    fileprivate func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsMultipleSelection = false
        tableView.estimatedRowHeight = 60.0
        navigationItem.title = "Orders"
        pullToRefreshControl.layoutIfNeeded() // to fix https://openradar.appspot.com/27516269
    }
    
    
    fileprivate func configureViewModel()  {
        viewModel = UsersViewModel()
        viewModelUpdateNotification = viewModel.users.addNotificationBlock({ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
                
            case .update:
                // in case new user was just added
                let previouslySelectedRowIndexPath = tableView.indexPathForSelectedRow
                tableView.reloadData()
                tableView.selectRow(at: previouslySelectedRowIndexPath, animated: false, scrollPosition: .none)
                
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

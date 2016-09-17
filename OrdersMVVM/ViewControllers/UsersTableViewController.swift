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
    var dataSource: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureViewModel()
        pullToRefresh(pullToRefreshControl)
    }

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserTableCell", forIndexPath: indexPath) as! UserTableCell
        cell.configure(name: viewModel.nameOfUser(at: indexPath.row), phone: viewModel.phoneOfUser(at: indexPath.row), pictureURL: viewModel.pictureURLOfUser(at: indexPath.row))
        return cell
    }
    
    
    // MARK: Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetail", sender: nil)
    }
    

    // MARK: - IBAction
    
    @IBAction func pullToRefresh(sender: UIRefreshControl) {
        sender.beginRefreshing()
        if tableView.contentOffset.y == 0 {
            tableView.setContentOffset(CGPoint(x: 0, y: -pullToRefreshControl.frame.size.height), animated: true)
        }
        
        viewModel.refreshData {
            sender.endRefreshing()
        }
    }
    

    // MARK: - Helpers
    
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
        navigationItem.title = "Orders"
    }
    
    
    private func configureViewModel()  {
        viewModel = UsersViewModel()
        viewModelUpdateNotification = viewModel.users?.addNotificationBlock({ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .Initial, .Update:
                // TODO: add row updates for insertions, deletions...
                tableView.reloadData()
                
            case .Error(let error):
                print("ViewModel update notification block error: \(error.localizedDescription)")
                break
            }
        })
    }
    
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let odersDetailVC = (segue.destinationViewController as! UINavigationController).topViewController as! OrdersDetailTableViewController
                odersDetailVC.user = viewModel.user(at: indexPath.row)
            }
        }
    }
}

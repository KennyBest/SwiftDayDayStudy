//
//  KBMenuTableViewController.swift
//  SwiftDayDayStudy
//
//  Created by llj on 2017/6/20.
//  Copyright © 2017年 llj. All rights reserved.
//

import UIKit

class KBMenuTableViewController: UITableViewController {
    
    lazy var menuItems = {
        return KBMenu.menuItems
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = "KennyBest"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension KBMenuTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        cell.accessoryType = .disclosureIndicator
        let (item, _) = menuItems[indexPath.row]
        cell.textLabel?.text = item
        
        return cell
    }
}

extension KBMenuTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let (_, vc) = menuItems[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

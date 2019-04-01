//
//  SettingsTableViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/30/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.black
        tableView.rowHeight = 94.0
        
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)

        cell.backgroundColor = UIColor.black
        cell.textLabel?.text = "Hello"
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.textStyle7
        cell.textLabel?.textColor = UIColor.white

        return cell
    }
    


}

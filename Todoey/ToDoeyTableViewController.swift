//
//  ViewController.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 02/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import UIKit

class ToDoeyTableViewController: UITableViewController {

    let itemArray=["Find Jack","Buy eggs","Destroy abinandhan"]
    override func viewDidLoad() {
        super.viewDidLoad()
       }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
     tableView.deselectRow(at: indexPath, animated: true)
    }

}


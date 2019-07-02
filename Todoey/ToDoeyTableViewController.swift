//
//  ViewController.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 02/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import UIKit

class ToDoeyTableViewController: UITableViewController {

    var itemArray=["Find Jack","Buy eggs","Destroy abinandhan"]
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

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield=UITextField()
        let alert=UIAlertController(title: "Add New Todoey Item", message:"", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textfield.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="add new item"
            textfield=alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
}


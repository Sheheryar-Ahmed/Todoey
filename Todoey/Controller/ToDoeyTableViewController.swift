//
//  ViewController.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 02/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import UIKit

class ToDoeyTableViewController: UITableViewController {

    var itemArray=[Item]()
    var defaults=UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
      let newItem=Item()
        newItem.title="Find Jack"
        newItem.done=false
      let newItem2=Item()
        newItem2.title="Buy Eggos"
        newItem2.done=false
      let newItem3=Item()
        newItem3.title="Destroy abnandhan"
        newItem3.done=false
        
        itemArray.append(newItem)
        itemArray.append(newItem2)
        itemArray.append(newItem3)
        if let items=defaults.array(forKey: "ToDoListArray") as? [Item]{
        itemArray=items
        }
    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item=itemArray[indexPath.row]
        cell.textLabel?.text=item.title
        
        if item.done==true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    //MARK - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemArray[indexPath.row].done==true{
           itemArray[indexPath.row].done=false
        }
        else{
            itemArray[indexPath.row].done=true
        }
        tableView.reloadData()
     tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield=UITextField()
        let alert=UIAlertController(title: "Add New Todoey Item", message:"", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem=Item()
            newItem.title=textfield.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
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


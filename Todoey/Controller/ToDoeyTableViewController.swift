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
    let dataFile=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        loadItems()
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
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       SaveItems()
        
     tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield=UITextField()
        let alert=UIAlertController(title: "Add New Todoey Item", message:"", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem=Item()
            newItem.title=textfield.text!
            
            self.itemArray.append(newItem)
            self.SaveItems()
           
              }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="add new item"
            textfield=alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }


    func SaveItems(){
        let encoder=PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFile!)
        }
            
        catch{
            print("Error in encoding")
        }
        tableView.reloadData()
        
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFile!) {
            let decoder=PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("Error decoding item array")
            }
        }
        
    }





}

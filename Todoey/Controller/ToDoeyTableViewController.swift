//
//  ViewController.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 02/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoeyTableViewController: UITableViewController {

    var toDoItems:Results<Item>?
   let realm=try! Realm()
    var selectedCategory:Category?{
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        )
     
       loadItems()
           }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item=toDoItems?[indexPath.row] {
        cell.textLabel?.text=item.title
        
        if item.done==true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
            }
            
        }
        else{
            cell.textLabel?.text="No Items Added"
        }
        return cell
    }
    
    //MARK - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item=toDoItems?[indexPath.row] {
            do{
              try realm.write {
                    item.done = !item.done
                }
            }
            catch{
                print("Error while updating")
            }
            
        }
        tableView.reloadData()
       
        
     tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield=UITextField()
        let alert=UIAlertController(title: "Add New Todoey Item", message:"", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in

            if let currentCategory=self.selectedCategory{
                do{
                    
                    try  self.realm.write {
                    let newItem=Item()
                    newItem.title=textfield.text!
                        newItem.dateCreated=Date()
                    currentCategory.items.append(newItem)
                    }
                }
                catch{
                    print("Errror while Saving new Items")
                }
                
            }
            self.tableView.reloadData()
              }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="add new item"
            textfield=alertTextField

        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    func loadItems(){
        toDoItems=selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }


 
}
extension ToDoeyTableViewController:UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        toDoItems=toDoItems?.filter("title CONTAINS[cd] %@",searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count==0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

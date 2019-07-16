//
//  ViewController.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 02/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import UIKit
import CoreData

class ToDoeyTableViewController: UITableViewController {

    var itemArray=[Item]()
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       SaveItems()
        
     tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield=UITextField()
        let alert=UIAlertController(title: "Add New Todoey Item", message:"", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            
            newItem.title=textfield.text!
            newItem.done=false
            newItem.parentCategory=self.selectedCategory
            
            
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
        do{
            try context.save()
           }
        catch{
            print("Error saving context \(error)")
        }
        tableView.reloadData()
        
    }
    func loadItems(with request:NSFetchRequest<Item>=Item.fetchRequest(),predicate:NSPredicate?=nil){
        let categorypredicate=NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate=predicate{
            let compoundPredicate=NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,predicate!])
            request.predicate=compoundPredicate
        }
        else{
            request.predicate=categorypredicate
        }
        do{
            itemArray = try context.fetch(request)
        }
        catch{
            print("Error while fetching data\(error)")
        }
        tableView.reloadData()
   }
}
extension ToDoeyTableViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request:NSFetchRequest<Item>=Item.fetchRequest()
        let predicate=NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors=[NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request,predicate: predicate)
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

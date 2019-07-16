//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 12/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray=[Category]()
       let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
       }
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for:indexPath)
        cell.textLabel?.text=categoryArray[indexPath.row].name
        return cell
    }

    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories(){
        do{
            try context.save()
        }
        catch{
            print("Error saving context \(error)")
        }
        tableView.reloadData()
        
    }
    func loadItems(with request:NSFetchRequest<Category>=Category.fetchRequest()){
        
        do{
            categoryArray = try context.fetch(request)
        }
        catch{
            print("Error while fetching data\(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories

 
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add New Category", message: "", preferredStyle:.alert)
        let action=UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem=Category(context: self.context)
            newItem.name=textField.text
 
            
            self.categoryArray.append(newItem)
            self.saveCategories()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Add New Category"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did selected Row")
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC=segue.destination as! ToDoeyTableViewController
        
        if let indexPath=tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory=categoryArray[indexPath.row]
        }
    }
    
    
}

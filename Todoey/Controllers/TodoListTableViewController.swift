//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by Deven Day on 3/29/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    //MARK: - Properties
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupItemArray()
    }
    
    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        addItem()
    }
    
    //MARK: - Helper Functions
    func setupItemArray() {
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        if let  items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    func addItem() {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text ?? ""
        
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
  
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

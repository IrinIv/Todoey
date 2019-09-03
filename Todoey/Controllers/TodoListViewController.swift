//
//  ViewController.swift
//  Todoey
//
//  Created by Irina Ivanushkina on 9/1/19.
//  Copyright © 2019 Irina Ivanushkina. All rights reserved.
//

import UIKit

class TodoLIstViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items}
        
        let newItem = Item()
        newItem.title = "Buy coffee"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy milk"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Make a call"
        itemArray.append(newItem3)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - TableView DataSource Methods

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
    
        cell.textLabel?.text = item.title
            
            //Ternary Operator ==>
            //value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
            
//            if item.done == true {
//                cell.accessoryType = .checkmark
//
//            } else {
//                cell.accessoryType = .none
//            }
        
        return cell
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    //MARK - TableView Delegate methods
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print (itemArray[indexPath.row])
    
            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
            
            tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New items
    
    @IBAction func adButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo List Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user clicks the Add Item button on out UI alert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}


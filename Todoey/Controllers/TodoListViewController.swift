//
//  ViewController.swift
//  Todoey
//
//  Created by Irina Ivanushkina on 9/1/19.
//  Copyright © 2019 Irina Ivanushkina. All rights reserved.
//

import UIKit
import RealmSwift


class TodoLIstViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var todoList: Results<Item>?
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items}
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - TableView DataSource Methods

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
            if let item = todoList?[indexPath.row] {
                
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
                
            } else {
                
                cell.textLabel?.text = "No Items added yet"
            }
    
        return cell
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoList?.count ?? 1
    }
    
    //MARK - TableView Delegate methods
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print (itemArray[indexPath.row])
            
            if let item = todoList?[indexPath.row] {
                
                do {
                try realm.write {
                    //realm.delete(item)
                    item.done = !item.done
                    }
                } catch {
                    print("Error saving done status, \(error)")
            
                }
            }
            
            tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New items
    
    @IBAction func adButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo List Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user clicks the Add Item button on out UI alert
            
            if let currentCategory = self.selectedCategory {
        
            do {
                try self.realm.write{
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)}
                
            } catch {
                print("Error saving new items , \(error)")
            }
    }
            
            self.tableView.reloadData()
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Data Manipulation Methods
    
    
    func loadItems() {
        
        todoList = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
  
        }
    
    }

extension TodoLIstViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoList = todoList?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }

    }

}




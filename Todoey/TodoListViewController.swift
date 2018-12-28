//
//  ViewController.swift
//  Todoey
//
//  Created by Christos Lianos on 2018-11-09.
//  Copyright © 2018 Christos Lianos. All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: UITableViewController{
   
    var todoItems: Results<Item>?
    
let realm = try!Realm ()
    
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    
   // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
  
    
    //let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //print(dataFilePath)
        
        
      //  if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
       //    itemArray = items
      // }
    }
    
    
    // Mark 1 table view data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
         if let item = todoItems?[indexPath.row] {
            
            
            cell.textLabel?.text = item.title
            // ternary operator value = condition ? valueif true: valueif false
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Items Added"
        }

        
        return cell
       
        }
    
    // Mark 2 table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                //realm.delete(item)
                item.done = !item.done
            }
            }catch {
                print ("Error saving done status\(error)")
            }
        }
        
        tableView.reloadData()
    
        
        tableView.deselectRow(at: indexPath, animated: true)
        

        
    }
    
    //Add new items
    
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add new item", style: .default) { (action) in
            // what happens when the user clicks the UIaLERT
            
            
           // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item ()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                 }
                } catch {
                    print ("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()
    
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        //let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        
       tableView.reloadData()
}

}

// Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    todoItems = todoItems?.filter("tittle CONTAINS [CD] ‰@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    
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



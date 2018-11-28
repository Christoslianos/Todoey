//
//  ViewController.swift
//  Todoey
//
//  Created by Christos Lianos on 2018-11-09.
//  Copyright © 2018 Christos Lianos. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
   
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
 

    
    //let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print(dataFilePath)
        
        
        
 loadItems()
        
      //  if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
       //    itemArray = items
      // }
    }
    
    
    // Mark 1 table view data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        // ternary operator value = condition ? valueif true: valueif false
        cell.accessoryType = item.done ? .checkmark : .none
        
       // if item.done == true {
          //  cell.accessoryType = .checkmark
       // }
       // else {
          //  cell.accessoryType = .none
     //   }
        
        
        return cell
       
        }
    
    // Mark 2 table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       // if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
       // tableView.cellForRow(at: indexPath)?.accessoryType = .none
       // }
       // else {
         // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
      //  }
        
         saveItems()
        //tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        

    
        
    }
    
    //Add new items
    
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add new item", style: .default) { (action) in
            // what happens when the user clicks the UIaLERT
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
           self.itemArray.append(newItem)
            
           self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems () {
        
        let encoder = PropertyListEncoder ()
        
        do{
            let data =  try encoder.encode(self.itemArray)
            try data.write(to:self.dataFilePath!)
        }
        catch {
            print ("error encoding the message\(error)")
        }
        
        
        //  self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
        self.tableView.reloadData()
    }
    
    func loadItems (){
        if   let data =  try? Data( contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder ()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding the message\(error)")
        }
   
        
    }
    
    
}
}

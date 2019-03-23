//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Christos Lianos on 2018-12-03.
//  Copyright © 2018 Christos Lianos. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeViewController {
    
    
    let realm = try! Realm()
    var categories : Results <Category>?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     loadCategories()
       
        tableView.separatorStyle = .none
    }
    
    // MARK 1 TABLEVIEW DATASOURCE METHDOS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categories?.count ?? 1
    }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
            cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
            
     cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "1D9BF6")
            
           
            return cell
            
    }
    
    // MARK 4 TABLEVIEW DELAGATE METHODS
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
   
    // MARK 2 TABLEVIEW MANUPALATION METHODS
    
    
    func save( category: Category) {
        
        do{
            try realm.write {
                realm.add(category)
             }
        } catch {
            print("error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func  loadCategories(){
        
        categories = realm.objects(Category.self)
   

        self.tableView.reloadData()
        
    }
    
    //Mark - Delete data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do {
                try self.realm.write {
                    realm.delete (categoryForDeletion)
                }
            } catch {
                print ("Error deleting categories\(error)")
            }
        }
    }
    
    // MARK 3 ADD NEW CATEGORIES
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add new Category", style: .default) { (action) in
           
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
    
            
            self.save(category:newCategory)
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
 
    }

  



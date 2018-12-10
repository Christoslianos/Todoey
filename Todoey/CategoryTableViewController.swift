//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Christos Lianos on 2018-12-03.
//  Copyright © 2018 Christos Lianos. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
     loadCategories()

    }
    
    // MARK 1 TABLEVIEW DATASOURCE METHDOS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            
            let category = categoryArray[indexPath.row]
            
            cell.textLabel?.text = category.name
            
            return cell
            
    }
    
    // MARK 4 TABLEVIEW DELAGATE METHODS
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
   
    // MARK 2 TABLEVIEW MANUPALATION METHODS
    
    
    func saveCategories() {
        
        do{
            try context.save()
        }
        catch {
            print ("error saving category \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    func  loadCategories(){
   
    let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        }catch {
            print ("Error loading the categories\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    // MARK 3 ADD NEW CATEGORIES
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add new Category", style: .default) { (action) in
           
            let newCategory = Category (context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
        
 
    }
  


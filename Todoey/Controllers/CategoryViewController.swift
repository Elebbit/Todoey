//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by 최연택 on 2018. 4. 24..
//  Copyright © 2018년 최연택. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        loadCategory(with: request)
        
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CategoryCell")
        
        let item = categoryArray[indexPath.row].name
        cell.textLabel?.text = item
        
        return cell
    }
    
    
    
    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory() {
        
        do {
            try self.context.save()
        } catch {
            print("Error saving data in context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest <Category>) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching categories \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title:"New Category", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (categoryTextField) in
            categoryTextField.placeholder = "Create New Category"
            textField = categoryTextField
        }
        
        alert.addAction(UIAlertAction(title: "Add Category", style: .default)
        { (_) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            self.tableView.reloadData()
        })
        
        self.present(alert, animated: true)
        
    }
    
}

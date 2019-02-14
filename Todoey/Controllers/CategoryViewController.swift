//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Smeet Patel on 2/11/19.
//  Copyright © 2019 Smeet Patel. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()


    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell" , for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row] 
        }
    }
    
    
    
    

    

    

    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        
        let alert = UIAlertController(title: "Add new Todo Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Data Manipulation methods
    
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch{
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories(){
        
        
        categories = realm.objects(Category.self)
        
 
        tableView.reloadData()

    
    }
    
}

//extension TodoListViewController: UISearchBarDelegate{
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
//
//        request.predicate = predicate
//
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//
//        request.sortDescriptors = [sortDescriptor]
//
//        loadItems(with: request)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}


    
    


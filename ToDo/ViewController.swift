//
//  ViewController.swift
//  ToDo
//
//  Created by Simon Mc Neil on 2018-01-11.
//  Copyright © 2018 Simon Mc Neil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tasks : [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    //gets the data before the controller is loaded
    override func viewWillAppear(_ animated: Bool) {
        //get the data from core data
        getData()
        
        //reload the table view
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        if task.isimportant {
            cell.textLabel?.text = "🔥 \(task.name!)"
        } else {
            cell.textLabel?.text = task.name!
        }
        return cell
    }
    
    func getData() {
        //gets are data from the table is done from the line of code (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
        //get the data
        tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("fetching failed")
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    //deleting the data, and creating a reference and context to the point and then re updating our database
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
            tasks = try context.fetch(Task.fetchRequest())
            } catch {
                print("fetching failed")
            }
        }
        tableView.reloadData()
    }
}



















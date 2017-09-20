//
//  ViewController.swift
//  Do It
//
//  Created by Connor Jennison on 9/18/17.
//  Copyright © 2017 Connor Jennison. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sort the array so that important tasks show at the top
        tasks.sort(by: {(leftProfile, rightProfile) -> Bool in return leftProfile.important && rightProfile.important == false})
        
        //Set up dataSource and delegate
        tableView.dataSource = self; tableView.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Reset the view for when tasks are added
    override func viewWillAppear(_ animated: Bool) {
        getTasks()
        tasks.sort(by: {(leftProfile, rightProfile) -> Bool in return leftProfile.important && rightProfile.important == false})
        tableView.reloadData()
    }
    
    //Set the amount of rows to be the amount of variables in our task array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count;
    }
    
  
    //Set up each cell of the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
      
        if task.important{
            cell.textLabel?.text = "❗️\t\(task.name!)"
        }   else{
            cell.textLabel?.text = "\t\(task.name!)"
        }
        
        return cell
    }
    
    //Perform the segue when a row gets selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        performSegue(withIdentifier: "selectTaskSegue", sender: task )
    }
    
    //Perform the segue when the user wants to add an item
    @IBAction func addItemButton(_ sender: Any) {
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    //Function to get the tasks from CoreData so that screen can refresh when tasks are added/deleted
    func getTasks() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            tasks = try context.fetch(Task.fetchRequest()) as! [Task]
            print(tasks)
        }
        
        catch{
            print("ERROR")
        }
        
        
    }
    
    //Prepare for segue when user chooses a task
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectTaskSegue" {
            let nextVC = segue.destination as! CompleteTaskViewController
            nextVC.task = sender as? Task
        }
        
    }
}


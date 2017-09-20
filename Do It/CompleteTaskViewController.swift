//
//  CompleteTaskViewController.swift
//  Do It
//
//  Created by Connor Jennison on 9/20/17.
//  Copyright © 2017 Connor Jennison. All rights reserved.
//

import UIKit

class CompleteTaskViewController: UIViewController {

    var task: Task? = nil
    
    @IBOutlet weak var taskNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if task!.important{
            taskNameLabel.text = "❗️\(task!.name!)"
        } else {
            taskNameLabel.text = task!.name!
        }
    }

    @IBAction func completeTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(task!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
}

//
//  TaskTableViewController.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-06.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit
import RealmSwift

class TaskTableViewController: UITableViewController {

    var tasks : [Results<Task>] = []
    
    let databaseManager = DatabaseManager.sharesdInstance
    
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .long
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        
        navigationItem.leftBarButtonItem = editButtonItem
        //target matn barname haminjast
        //action mesle drag kardan button
        let addButton=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showTaskViewController(_:)))
        
        navigationItem.rightBarButtonItem = addButton
        
        
        
        databaseManager.read(Task.self, completion: {
            
            (task) in
            tasks.insert(task, at: 0)
            
            tableView.reloadData()
        })
        
        
    }
    
    func showTaskViewController(_ sender : Any) {
       
        
        let taskViewController = storyboard?.instantiateViewController(withIdentifier: "TaskViewControllerStoryBoard") as! TaskViewController
       //neshoon mide
        present(taskViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks[section].count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseTaskIdentifier", for: indexPath)

        // Configure the cell...
        let myTask = tasks[indexPath.section][indexPath.row]
        if let myCell = cell as? TaskTableViewCell{
            myCell.labelTaskName.text = myTask.taskName
            myCell.labelTaskStatus.text = myTask.taskStatus
            myCell.labelStartDate.text = dateFormatter.string(from: myTask.taskStartDate)
            myCell.labelEndDate.text = dateFormatter.string(from: myTask.taskEndDate)
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

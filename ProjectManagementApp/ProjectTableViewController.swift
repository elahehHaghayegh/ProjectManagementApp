//
//  ProjectTableViewController.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-02.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectTableViewController: UITableViewController {

    var projects : [Results<Project>] = []
    
    var dateFormatter = DateFormatter()
    
    let databaseManager = DatabaseManager.sharesdInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .long
        
        
        navigationItem.leftBarButtonItem = editButtonItem
        
       let addButton=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showProjectViewController(_:)))
        
        navigationItem.rightBarButtonItem = addButton

        
        
        
        
        databaseManager.read(Project.self, completion: {
            
            (proj) in
            projects.insert(proj, at: 0)
            
            tableView.reloadData()
        })
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

 
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return projects[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let myProject = projects[indexPath.section][indexPath.row]
        if let myCell = cell as? ProjectTableViewCell{
            
            myCell.projectName.text = myProject.projectName
            myCell.projectStartDate.text = dateFormatter.string(from: myProject.projectStartDate)
            myCell.projectEndDate.text = dateFormatter.string(from: myProject.projectEndDate)
        // Configure the cell...
        }
        return cell
    }
    
    
    func showProjectViewController(_ sender:Any) {
        
        let projectViewController = storyboard?.instantiateViewController(withIdentifier: "projectViewControllerStoryBoard") as! ProjectViewController
        //neshoon mide
        present(projectViewController, animated: true, completion: nil)
        
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
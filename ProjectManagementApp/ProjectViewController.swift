//
//  ProjectViewController.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-03.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectViewController: UIViewController {
    
    @IBOutlet weak var textFieldProjectName: UITextField!
    @IBOutlet weak var textFieldStartDate: UITextField!
    @IBOutlet weak var textFieldEndDate: UITextField!
    
    @IBOutlet weak var btnAddTask: UIButton!
    
    let datePicker = UIDatePicker()
    
    var dateFormatter = DateFormatter()
    
    var project = Project()
    
    let databaseManager = DatabaseManager.sharesdInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnAddTask.isEnabled = false
        // Do any additional setup after loading the view.
        
        dateFormatter.dateStyle = .long
        
        datePicker.datePickerMode = .date
        textFieldStartDate.inputView = datePicker
        textFieldEndDate.inputView = datePicker
        
        
        
        //add two button save and cancel   in navigationbar
        
        
        let cancelButton=UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton=UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        navigationItem.rightBarButtonItem = saveButton
        
        
        
        
        
        //create bar buttons
        let barButtonDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneMethod))
        
        let barButtonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let barButtonCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelMethod))
        
        //on the top of picker we need toolbar to put two button on it
        //instead of drag and drop we can create widget with coding
        let toolbar = UIToolbar()
        //with out this command the buttons not working
        toolbar.sizeToFit()
        toolbar.setItems([barButtonCancel,barButtonSpace,barButtonDone], animated: true)
        textFieldStartDate.inputAccessoryView = toolbar
        textFieldEndDate.inputAccessoryView = toolbar
        
        
        
        
    }
    
    
    
    
    
    func save(_ sender : UIButton) {
        
        guard let projectName = textFieldProjectName.text,
            let startDate = textFieldStartDate.text,
            let endDate = textFieldEndDate.text    else { return  }
        
        let myProject = Project()
        
        myProject.projectName = projectName
        myProject.projectStartDate = dateFormatter.date(from: startDate )!
        myProject.projectEndDate = dateFormatter.date(from: endDate)!
        
        for task in project.tasks {
            myProject.tasks.append(task)
        }
        databaseManager.write(object: myProject)
       
        btnAddTask.isEnabled = true
        
        
        
    }
    
    func cancel()  {
        let projectTableViewControllerN = storyboard?.instantiateViewController(withIdentifier: "ProjectTableViewControllerStory") as? UINavigationController
        
//        let projectTableViewController = projectTableViewControllerN?.viewControllers[0] as? ProjectTableViewController
//        projectTableViewController?.tableView
        present(projectTableViewControllerN!, animated: true, completion: nil)
    }
    
    
    func doneMethod()  {
        if textFieldStartDate.isEditing{
            textFieldStartDate.text = dateFormatter.string(from: datePicker.date)
        }else if textFieldEndDate.isEditing{
            textFieldEndDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
    }
    
    func cancelMethod()  {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationN = segue.destination as? UINavigationController{
            if let destination = destinationN.viewControllers[0] as? TaskTableViewController{
                destination.project = project
                }
        }
    }
    
    
}










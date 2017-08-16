//
//  TaskViewController.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-06.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var textFieldTaskName: UITextField!
    
    @IBOutlet weak var textFieldTaskStatus: UITextField!
    
    @IBOutlet weak var textFieldtaskStartDate: UITextField!
    
    @IBOutlet weak var textFieldtaskEndDate: UITextField!
    
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    
    var dateFormatter = DateFormatter()
    let databaseManger = DatabaseManager.sharesdInstance
    
    var task = Task()
    var project = Project()
    var string = ""
    
    let status = ["Todo","Inprocess","Done"]
    //query result
    var taskObjects = [Results<Task>]()
    
    var taskTableViewController = TaskTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        dateFormatter.dateStyle = .long
        
        datePicker.datePickerMode = .date
        textFieldtaskStartDate.inputView = datePicker
        textFieldtaskEndDate.inputView = datePicker
        
        textFieldTaskStatus.inputView = pickerView
    //    textFieldTaskStatus.inputView = pickerView
        // Do any additional setup after loading the view.
        
        
        if task.taskName != ""{
            
            textFieldTaskName.text = task.taskName
            textFieldTaskStatus.text = task.taskStatus
            textFieldtaskStartDate.text = dateFormatter.string(from: task.taskStartDate)
            textFieldtaskEndDate.text = dateFormatter.string(from: task.taskEndDate)
            
        }
        
        
        let saveButton=UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveInDatabase))
        
        navigationItem.rightBarButtonItem = saveButton
        
        
        let cancelButton=UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        navigationItem.leftBarButtonItem = cancelButton
        
        
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
        textFieldtaskStartDate.inputAccessoryView = toolbar
        textFieldtaskEndDate.inputAccessoryView = toolbar
        textFieldTaskStatus.inputAccessoryView = toolbar
        
    }
        //pickerview for task status
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return status.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

                
                string = "\(status[row])"
                return string
           
        }
    
    
    func saveInDatabase(){
        guard let taskName = textFieldTaskName.text,
            let taskStatus = textFieldTaskStatus.text,
            let taskStartDate = textFieldtaskStartDate.text,
            let taskEndDate = textFieldtaskEndDate.text     else { return  }
       
       let myProject = Project()
       
        myProject.id = project.id
        myProject.projectName = project.projectName
        myProject.projectStartDate = project.projectStartDate
        myProject.projectEndDate = project.projectEndDate
        
        
        let datetaskStartDate = dateFormatter.date(from: taskStartDate)
        let datetaskEndDate = dateFormatter.date(from: taskEndDate)
        
        for task1 in project.tasks {
            myProject.tasks.append(task1)
        }
        
        if( datetaskStartDate! < myProject.projectStartDate || datetaskEndDate! > myProject.projectEndDate){
            //open an alert
            
            //alert
            
            let alert = UIAlertController(title: "Warning", message: "Start date or end date is incorrect, please retry!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }

        
        let task2 = Task()
        
        if task.taskName != "" {
            task2.id = task.id
        }
        task2.taskName = taskName
        task2.taskStatus = taskStatus
        task2.taskStartDate = dateFormatter.date(from: taskStartDate)!
        task2.taskEndDate = dateFormatter.date(from: taskEndDate)!
        myProject.tasks.append(task2)
        
        databaseManger.write(object: myProject)
        
        //reload TaskTableViewControler
        
        taskTableViewController.tableView.reloadData()
        
        
        let taskTableViewControllerR = storyboard?.instantiateViewController(withIdentifier: "NavigationTaskTableViewControllerStory")
        present(taskTableViewControllerR!, animated: true, completion: nil)
        
    
        
    }
    
    
    func cancel(){
       ///// self.view.endEditing(true)
        let taskTableViewControllerR = storyboard?.instantiateViewController(withIdentifier: "NavigationTaskTableViewControllerStory")
        present(taskTableViewControllerR!, animated: true, completion: nil)
    }
    
    func doneMethod(){
        
        if textFieldtaskStartDate.isEditing{
            textFieldtaskStartDate.text = dateFormatter.string(from: datePicker.date)
        }else if textFieldtaskEndDate.isEditing{
            textFieldtaskEndDate.text = dateFormatter.string(from: datePicker.date)
        }else if textFieldTaskStatus.isEditing{
            textFieldTaskStatus.text = string
        }
        self.view.endEditing(true)
    }
    
    func cancelMethod(){
        self.view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  TaskViewController.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-06.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UIViewController {

    
    @IBOutlet weak var textFieldTaskName: UITextField!
    
    @IBOutlet weak var textFieldTaskStatus: UITextField!
    
    @IBOutlet weak var textFieldtaskStartDate: UITextField!
    
    @IBOutlet weak var textFieldtaskEndDate: UITextField!
    
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    
    var dateFormatter = DateFormatter()
    let databaseManger = DatabaseManager.sharesdInstance
    
    var task = Task()
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .long
        
        datePicker.datePickerMode = .date
        textFieldtaskStartDate.inputView = datePicker
        textFieldtaskEndDate.inputView = datePicker
        textFieldTaskStatus.inputView = pickerView
        // Do any additional setup after loading the view.
        
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
    
    func saveInDatabase(){
        guard let taskName = textFieldTaskName.text,
            let taskStatus = textFieldTaskStatus.text,
            let taskStartDate = textFieldtaskStartDate.text,
            let taskEndDate = textFieldtaskEndDate.text     else { return  }
        
        task.taskName = taskName
        task.taskStatus = taskStatus
        task.taskStartDate = dateFormatter.date(from: taskStartDate)!
        task.taskEndDate = dateFormatter.date(from: taskEndDate)!
        
        databaseManger.write(object: task)
        //TaskTableViewController.tableView.reloadData()
    }
    
    
    func cancel(){
        
    }
    
    func doneMethod(){
        
        if textFieldtaskStartDate.isEditing{
            textFieldtaskStartDate.text = dateFormatter.string(from: datePicker.date)
        }else if textFieldtaskEndDate.isEditing{
            textFieldtaskEndDate.text = dateFormatter.string(from: datePicker.date)
        }else if textFieldTaskStatus.isEditing{
            textFieldTaskStatus.text = String(describing: pickerView)
        }
        
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

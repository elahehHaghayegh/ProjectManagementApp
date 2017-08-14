//
//  EditViewController.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-14.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    
    @IBOutlet weak var textFieldProjectName: UITextField!
    
    @IBOutlet weak var textFieldProjectStartDate: UITextField!
    

    @IBOutlet weak var textFieldProjectEndDate: UITextField!
    
    let datePicker = UIDatePicker()
    var dateFormatter = DateFormatter()
    
    var project = Project()
    let databaseManger = DatabaseManager.sharesdInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateFormatter.dateStyle = .long
        datePicker.datePickerMode = .date
        textFieldProjectStartDate.inputView = datePicker
        textFieldProjectEndDate.inputView = datePicker
        
        
        textFieldProjectName.text = project.projectName
        textFieldProjectStartDate.text = dateFormatter.string(from: project.projectStartDate)
        textFieldProjectEndDate.text = dateFormatter.string(from: project.projectEndDate)
        //add two button save and cancel   in navigationbar
        
        
        let cancelButton=UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton=UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        navigationItem.rightBarButtonItem = saveButton
        
      //create bar buttons for Datepicker
        let barButtonDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneMethod))
        
        let barButtonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let barButtonCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelMethod))
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.setItems([barButtonCancel,barButtonSpace,barButtonDone], animated: true)
        textFieldProjectStartDate.inputAccessoryView = toolBar
        textFieldProjectEndDate.inputAccessoryView = toolBar
    }

    func cancel(){
        let projectTableViewControllerR = storyboard?.instantiateViewController(withIdentifier: "ProjectTableViewControllerStory") as? UINavigationController
        present(projectTableViewControllerR!, animated: true, completion: nil)
        
    }
    
    func save(){
        
    }
    
    func cancelMethod(){
        self.view.endEditing(true)
    }
    
    func doneMethod(){
        if textFieldProjectStartDate.isEditing{
            textFieldProjectStartDate.text = dateFormatter.string(from: datePicker.date)
        }else if textFieldProjectEndDate.isEditing{
            textFieldProjectEndDate.text = dateFormatter.string(from: datePicker.date)
        }
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

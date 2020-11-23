//
//  AddTaskViewController.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var taskDateButton: InputViewButton!
    @IBOutlet weak var taskCategoryButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createEditButton: RoundRectButton!
    var categoryId = "0"
    var editingTask:TaskItem?
    var isEditingTask = false
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        styleUI()
    }
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateButtonDidTap(_ sender: Any) {
        //After clicked button show picker
        showDatePicker()
    }
    
    @IBAction func createButtonDidTap(_ sender: Any) {
        let taskDescription = taskDescriptionTextView.text ?? ""
        
        //Control for task description is empty
        if !taskDescription.isEmpty{
            
            //Control for updating task
            if isEditingTask{
                editTask()
            }else{
                createTask()
            }
            self.dismiss(animated: true, completion: nil)
        }else{
            CommonUtility.shared.prepareBasicAlert(message: "Please fill the task description", title: "Error", buttonTitle: "OK", viewController: self)
        }
    }
}

extension AddTaskViewController{
    /// Styles ui elements
    func styleUI() {
        if let category = CategoryProvider.category(for:self.categoryId){
            self.taskCategoryButton.setTitle("Category: " + category.name, for: .normal)
        }
        
        //Control for updating task
        if isEditingTask{
            self.titleLabel.text = "Edit Task"
            if let taskToEdit = self.editingTask{
                self.taskDescriptionTextView.text = taskToEdit.taskDescription
                let dateTitle = "Date: " + taskToEdit.date.toDateString(format: "HH:mm · dd LLLL yyyy")
                self.taskDateButton.setTitle(dateTitle, for: .normal)
                self.createEditButton.setTitle("EDIT", for: .normal)
            }
        }else{
            self.taskDateButton.setTitle("Add Date", for: .normal)
            self.taskDescriptionTextView.text = ""
            self.titleLabel.text = "New Task"
            self.createEditButton.setTitle("CREATE", for: .normal)
        }
    }
}

//MARK: - PROVIDER FUNCTIONS
extension AddTaskViewController{
    
    ///Update editingTask with new values
    func createTask(){
        let newTask = TaskItem(taskDescription: self.taskDescriptionTextView.text, date: datePicker.date, categoryId:  categoryId)
        TaskProvider.create(task:newTask)
    }
    
    ///Update editingTask with new values
    func editTask(){
        guard var taskToEdit = self.editingTask else{ return }
        taskToEdit.date = datePicker.date
        taskToEdit.taskDescription = self.taskDescriptionTextView.text
        TaskProvider.update(task:taskToEdit)
    }
}

extension AddTaskViewController {
    ///Show date picker at bottom toolbar
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //Check for ios 13.4 or higher
        if #available(iOS 13.4, *) {
            datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style:  .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        // add toolbar to button
        taskDateButton.inputAccessoryView = toolbar
        // add datepicker to button
        taskDateButton.inputView = datePicker
    }
    
    ///Calls after user selects date and press done
    @objc func donedatePicker(){
        let dateTitle = "Date: " + datePicker.date.toDateString(format: "HH:mm · dd LLLL yyyy")
        taskDateButton.setTitle(dateTitle, for: .normal)
        self.view.endEditing(true)
    }
    
    ///Calls after user press cancel button
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

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
        showDatePicker()
    }
    
    @IBAction func createButtonDidTap(_ sender: Any) {
        let taskDescription = taskDescriptionTextView.text ?? ""
        if !taskDescription.isEmpty{
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
    
    func styleUI() {
        if let category = CategoryProvider.category(for:self.categoryId){
            self.taskCategoryButton.setTitle("Category: " + category.name, for: .normal)
        }
        
        if isEditingTask{
            self.titleLabel.text = "Edit Task"
            if let taskToEdit = self.editingTask{
                self.taskDescriptionTextView.text = taskToEdit.taskDescription
                let dateTitle = "Date: " + taskToEdit.date.toDateString(format: "HH:mm · dd LLLL yyyy")
                self.taskDateButton.setTitle(dateTitle, for: .normal)
            }
        }else{
            self.taskDateButton.setTitle("Add Date", for: .normal)
            self.taskDescriptionTextView.text = ""
            self.titleLabel.text = "New Task"
        }
    }
}

extension AddTaskViewController{
    func createTask(){
        let newTask = TaskItem(taskDescription: self.taskDescriptionTextView.text, date: datePicker.date, categoryId:  categoryId)
        TaskProvider.create(task:newTask)
    }
    
    func editTask(){
        guard var taskToEdit = self.editingTask else{ return }
        taskToEdit.date = datePicker.date
        taskToEdit.taskDescription = self.taskDescriptionTextView.text
        TaskProvider.update(task:taskToEdit)
    }
}

extension AddTaskViewController {
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style:  .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        // add toolbar to textField
        taskDateButton.inputAccessoryView = toolbar
        // add datepicker to textField
        taskDateButton.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let dateTitle = "Date: " + datePicker.date.toDateString(format: "HH:mm · dd LLLL yyyy")
        taskDateButton.setTitle(dateTitle, for: .normal)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

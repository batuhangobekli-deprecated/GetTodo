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
    @IBOutlet weak var taskDateButton: UIButton!
    @IBOutlet weak var taskCategoryButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var editingTask:TaskItem?
    var isEditingTask = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        styleUI()
    }
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateButtonDidTap(_ sender: Any) {
        
    }
    
    @IBAction func categoryButtonDidTap(_ sender: Any) {
        
    }
    @IBAction func createButtonDidTap(_ sender: Any) {
        if isEditingTask{
            editTask()
        }else{
            createTask()
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddTaskViewController{
    
    func styleUI() {
        if isEditingTask{
            self.titleLabel.text = "Edit Task"
            if let taskToEdit = self.editingTask{
                if let category = CategoryProvider.category(for: taskToEdit.categoryId){
                    self.taskCategoryButton.setTitle(category.name, for: .normal)
                }
                self.taskDescriptionTextView.text = taskToEdit.taskDescription
                self.taskDateButton.setTitle(taskToEdit.date.description, for: .normal)
            }
        }else{
            self.taskDateButton.setTitle("Add Date", for: .normal)
            self.taskCategoryButton.setTitle("Category", for: .normal)
            self.taskDescriptionTextView.text = ""
            self.titleLabel.text = "New Task"
        }
    }
    
    
    func createTask(){
        var newTask = TaskProvider.create()
        newTask.categoryId = "2"
        newTask.date = Date()
        newTask.taskDescription = self.taskDescriptionTextView.text
        TaskProvider.update(task: newTask)
    }
    
    func editTask(){
        
    }
}

//
//  CategoryDetailViewController.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController{
    @IBOutlet weak var tableViewTopView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryImageBackView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTotalTasksLabel: UILabel!
    var selectedCategory:CategoryItem?
    var taskList : [TaskItem] = []{
        didSet{
            self.tableView.reloadData()
            self.categoryTotalTasksLabel.text = "\(taskList.count) Tasks"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        styleUI()
        startObservingTasks()
        getTasks()
    }
    
    deinit {
        stopObservingTasks()
    }
    
    @objc func didTapEditBarButton(_ sender: Any) {
        guard let barButtonItem = sender as? UIBarButtonItem else{ return }
        self.showEditing(sender: barButtonItem)
    }
    
    @objc func didTapAddTaskButton(_ sender: Any) {
        self.presentAddEditViewController(taskToEdit: nil, isEdit: false)
    }
}

extension CategoryDetailViewController{
    func getTasks(){
        guard let category = self.selectedCategory else{ return }
        self.taskList = TaskProvider.tasks(categoryId: category.identifier)
    }
    
    func showEditing(sender: UIBarButtonItem)
    {
        let tableViewIsEditing = tableView.isEditing
        self.tableView.setEditing(!tableViewIsEditing, animated: true)
        sender.title = tableViewIsEditing ? "Edit" : "Done"
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelectionDuringEditing = true
        tableView.register(UINib.init(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    func styleUI(){
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(didTapEditBarButton))
        let addTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddTaskButton))
        navigationItem.rightBarButtonItems = [editButton, addTaskButton]
        self.navigationController?.navigationBar.tintColor = .white
        
        tableViewTopView.roundTop(radius: 15)
        categoryImageBackView.makeCircular()
        
        if let category = selectedCategory {
            self.categoryImageView.image = UIImage(systemName: category.imageString)
            let tintColor = UIColor(hexString: category.hexColorString)
            self.view.backgroundColor = tintColor
            self.categoryImageView.tintColor = tintColor
        }
    }
    
    func presentAddEditViewController(taskToEdit:TaskItem?,isEdit:Bool){
        guard let category = selectedCategory else { return }
        
        let storyBoard = UIStoryboard(name: "AddTask", bundle: nil)
        let addTaskViewController:AddTaskViewController = storyBoard.instantiateViewController()
        addTaskViewController.isEditingTask = isEdit
        addTaskViewController.categoryId = category.identifier
        
        if isEdit {
            guard let taskToEdit = taskToEdit else { return }
            addTaskViewController.editingTask = taskToEdit
        }
        self.present(addTaskViewController, animated: true, completion: nil)
    }
}

extension CategoryDetailViewController:TaskObserver{
    func onDidChange(tasks: [TaskItem]) {
        self.getTasks()
    }
}

extension CategoryDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TaskTableViewCell = tableView.dequeueReusableCell(at: indexPath)
        let task = self.taskList[indexPath.row]
        cell.configure(taskItem:task)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            TaskProvider.remove(task: self.taskList[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing{
            self.presentAddEditViewController(taskToEdit: self.taskList[indexPath.row], isEdit: true)
        }
    }
}



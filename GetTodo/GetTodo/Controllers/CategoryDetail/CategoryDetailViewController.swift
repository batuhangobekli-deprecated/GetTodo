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
    var selectedCategory:CategoryItem?
    var taskList : [TaskItem] = []{
        didSet{
            self.tableView.reloadData()
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
    
    @objc func didTapAddTask(_ sender: Any) {
        self.presentAddTaskViewController()
    }
}

extension CategoryDetailViewController{
    func getTasks(){
        self.taskList = TaskProvider.tasks()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    func styleUI(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddTask))
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
    
    func presentAddTaskViewController(){
        let storyBoard = UIStoryboard(name: "AddTask", bundle: nil)
        let addTaskViewController:AddTaskViewController = storyBoard.instantiateViewController()
        self.present(addTaskViewController, animated: true, completion: nil)
    }
}

extension CategoryDetailViewController:TaskObserver{
    func onDidChange(tasks: [TaskItem]) {
        self.taskList = tasks
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
}

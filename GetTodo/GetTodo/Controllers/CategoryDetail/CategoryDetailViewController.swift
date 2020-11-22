//
//  CategoryDetailViewController.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    @IBOutlet weak var tableViewTopView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryImageBackView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var selectedCategory:CategoryItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    func presentAddTaskViewController(){
      let storyBoard = UIStoryboard(name: "AddTask", bundle: nil)
      let addTaskViewController:AddTaskViewController = storyBoard.instantiateViewController()
      self.present(addTaskViewController, animated: true, completion: nil)
    }
    
    @objc func didTapAddTask(_ sender: Any) {
        self.presentAddTaskViewController()
    }
    
    func configViews(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddTask))
        self.navigationController?.navigationBar.tintColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewTopView.roundTop(radius: 15)
        categoryImageBackView.makeCircular()
        
        if let category = selectedCategory {
            self.categoryImageView.image = UIImage(systemName: category.imageString)
            let tintColor = UIColor(hexString: category.hexColorString)
            self.view.backgroundColor = tintColor
            self.categoryImageView.tintColor = tintColor
        }
    }
}

extension CategoryDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//
//  TaskTableViewCell.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDateLabel: UILabel!
    
    
    func configure(taskItem:TaskItem){
        taskNameLabel.text = taskItem.taskDescription
        taskDateLabel.text = taskItem.date.toString(format: "HH:mm · dd LLLL")
    }
}

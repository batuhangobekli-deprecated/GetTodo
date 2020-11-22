//
//  Date.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation

extension Date {
    func toDateString(format: String = "HH:mm · dd LLLL") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        formatter.locale = .current
        return formatter.string(from: self)
    }
}

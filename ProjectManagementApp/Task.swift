//
//  Task.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-02.
//  Copyright © 2017 elaheh. All rights reserved.
//

import Foundation
import RealmSwift

class Task : Object{
    
    dynamic var id = NSUUID().uuidString
    dynamic var taskName : String = ""
    dynamic var taskStatus : String = ""
    dynamic var taskDuration : Double = 0.0
    dynamic var taskStartDate = Date()
    dynamic var taskEndDate = Date()
    dynamic var taskEffort : Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}

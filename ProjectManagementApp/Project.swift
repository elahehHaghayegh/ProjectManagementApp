//
//  Project.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-02.
//  Copyright © 2017 elaheh. All rights reserved.
//

import Foundation
import RealmSwift

class Project: Object {
    
    dynamic var id = NSUUID().uuidString
    dynamic var projectName : String = ""
    dynamic var projectStartDate = Date()
    dynamic var projectEndDate = Date()
    let tasks = [Task]()
    
    
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
}

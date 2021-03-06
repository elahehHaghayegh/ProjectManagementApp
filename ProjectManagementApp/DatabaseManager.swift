//
//  DatabaseManager.swift
//  ProjectManagementApp
//
//  Created by elaheh on 2017-08-02.
//  Copyright © 2017 elaheh. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager: NSObject {
    
    //singelton
    public static let sharesdInstance = DatabaseManager()
    private override init(){}
    
    
    
    let realm = try? Realm()
    
    
    
    public func write(object : Project)   {
        
        try?realm?.write {
            
                if let duplicateProjectName = realm?.objects(Project.self).filter("projectName = %@",object.projectName){
                    if duplicateProjectName.count>0{
                        //update database
                        object.id = duplicateProjectName[0].id
                        realm?.add(object, update: true)
                        return
                    }
                }
            //baraye real update we should add update:true
            realm?.add(object, update: true)
        }
    }
    
    // T should extend object and it is generic
    //closure in front of completion
    // one type for return output using clouser
    
    public func read <T : Object>(_ model : T.Type,
                      
                      completion: (Results<T>)->()){
        let result = realm?.objects(model)
               if let res = result{
            //if we have result then call completion in closure
            completion(res)
            
        }
    }
    
    
    public func deleteItem<T:Object>(object : T){
        
        try! realm?.write {
            realm?.delete(object)
        }
        
        
    }
    
    
    
    public func deleteAll(){
        try? realm?.write {
            realm?.deleteAll()
        }
        
    }
    
    
    
    
}

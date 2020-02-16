//
//  Model.swift
//  ToDoList
//
//  Created by Nikita Robertson on 15.02.2020.
//  Copyright © 2020 Nikita Robertson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var tasks: [NSManagedObject] = []
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let managedContext = appDelegate.persistentContainer.viewContext
let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!

var name: String? {
    get { return UserDefaults.standard.string(forKey: "Userdata.name") }
    set { UserDefaults.standard.set(newValue, forKey: "Userdata.name") }
}
var secondName: String? {
    get { return UserDefaults.standard.string(forKey: "Userdata.secondName") }
    set { UserDefaults.standard.set(newValue, forKey: "Userdata.secondName") }
}

func addItem(_ name: String){
    let task = NSManagedObject(entity: entity, insertInto: managedContext)
    task.setValue(name, forKey: "name")
    do {
        try managedContext.save()
        tasks.append(task)
    } catch let error as NSError {
        print(error)
    }
}

func removeItem(at index: Int){
    managedContext.delete(tasks[index])
    do {
        try managedContext.save()
        tasks.remove(at: index)
    } catch let error as NSError {
        print(error)
    }
}

func loadCoreData(){
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
    do {
        tasks = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
        print(error)
    }
}

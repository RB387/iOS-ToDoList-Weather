//
//  ModelRealm.swift
//  ToDoList
//
//  Created by Nikita Robertson on 16.02.2020.
//  Copyright © 2020 Nikita Robertson. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

let realm = try! Realm()

class item: Object {
    @objc dynamic var name: String = ""
}

let tasksRealm = realm.objects(item.self)

func addItemRealm(_ name: String){
    try! realm.write({
        let task = item()
        task.name = name
        realm.add(task)
    })
}

func removeItemRealm(at index: Int){
    try! realm.write({ realm.delete(tasksRealm[index]) })
}




//
//  Item.swift
//  Todoey
//
//  Created by 최연택 on 2018. 4. 25..
//  Copyright © 2018년 최연택. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dataCreated : Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

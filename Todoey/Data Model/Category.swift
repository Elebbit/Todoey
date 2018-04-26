//
//  Category.swift
//  Todoey
//
//  Created by 최연택 on 2018. 4. 25..
//  Copyright © 2018년 최연택. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}

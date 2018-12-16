//
//  Category.swift
//  Todoey
//
//  Created by Christos Lianos on 2018-12-16.
//  Copyright © 2018 Christos Lianos. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
   @objc dynamic var name: String = ""
    let items = List<Item>()
}

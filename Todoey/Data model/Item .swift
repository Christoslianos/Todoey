//
//  Item .swift
//  Todoey
//
//  Created by Christos Lianos on 2018-11-20.
//  Copyright © 2018 Christos Lianos. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = " "
    var done: Bool = false
}

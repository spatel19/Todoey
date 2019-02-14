//
//  Category.swift
//  Todoey
//
//  Created by Smeet Patel on 2/13/19.
//  Copyright © 2019 Smeet Patel. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}

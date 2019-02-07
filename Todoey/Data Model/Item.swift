//
//  Items.swift
//  Todoey
//
//  Created by Smeet Patel on 2/7/19.
//  Copyright © 2019 Smeet Patel. All rights reserved.
//

import Foundation
import UIKit

class Item: Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
}

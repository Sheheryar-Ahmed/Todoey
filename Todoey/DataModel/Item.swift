//
//  Item.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 16/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title:String=""
    @objc dynamic var done:Bool=false
    var parentCategory=LinkingObjects(fromType: Category.self, property: "items")
    @objc dynamic var dateCreated:Date?
    
    
}

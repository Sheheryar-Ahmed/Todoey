//
//  Category.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 16/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String=""
   let items=List<Item>()
    
}

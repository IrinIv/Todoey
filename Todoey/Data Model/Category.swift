//
//  Category.swift
//  Todoey
//
//  Created by Irina Ivanushkina on 9/9/19.
//  Copyright © 2019 Irina Ivanushkina. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    
    let items = List<Item>()
    
}

//
//  Todo.swift
//  LAToDo
//
//  Created by Yuki Hirayama on 2022/09/10.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var limit: Date!
}

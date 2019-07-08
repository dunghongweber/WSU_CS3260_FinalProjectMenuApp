//
//  OrderItem.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import RealmSwift

class OrderItem: Object {
    @objc dynamic var itemName = ""
    @objc dynamic var itemPrice = ""
    @objc dynamic var itemPic = ""

}

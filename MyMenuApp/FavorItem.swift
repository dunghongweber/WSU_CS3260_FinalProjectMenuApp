//
//  FavorItem.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import RealmSwift

class FavorItem: Object {
    @objc dynamic var itemName = ""
    @objc dynamic var itemPrice = ""
    @objc dynamic var itemPic = ""
    @objc dynamic var itemDescription = ""

}

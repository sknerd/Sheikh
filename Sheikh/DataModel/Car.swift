//
//  Car.swift
//  Sheikh
//
//  Created by renks on 17/10/2019.
//  Copyright © 2019 Renald Shchetinin. All rights reserved.
//

import Foundation
import RealmSwift

class Car: Object {
    
    @objc dynamic var brand = ""
    @objc dynamic var model = ""
    @objc dynamic var year = 0
    @objc dynamic var bodyStyle = ""
    @objc dynamic var imageData: Data?
    

    convenience init(brand: String, model: String, year: Int, bodyStyle: String) {
        
        self.init()
        self.brand = brand
        self.model = model
        self.year = year
        self.bodyStyle = bodyStyle
        self.imageData = imageData
    }
}

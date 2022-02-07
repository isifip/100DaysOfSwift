//
//  Person.swift
//  Project10
//
//  Created by Irakli Sokhaneishvili on 07.02.22.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}

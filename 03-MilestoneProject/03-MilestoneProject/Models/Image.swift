//
//  Image.swift
//  03-MilestoneProject
//
//  Created by Irakli Sokhaneishvili on 09.02.22.
//

import UIKit

class Image: Codable {
    var caption: String
    var imageName: String
    
    init(caption: String, imageName: String) {
        self.caption = caption
        self.imageName = imageName
    }
}

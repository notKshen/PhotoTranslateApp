//
//  SampleModel.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import UIKit
import SwiftData

@Model
class ImageModel {
    static var currentID: Int = 0
    var id: Int?
    var name: String
    var translation: String?
    @Attribute(.externalStorage)
    var data: Data?
    var image: UIImage? {
        if let data {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
    init(name: String, data: Data? = nil) {
        ImageModel.currentID += 1
        self.id = ImageModel.currentID
        self.name = name
        self.data = data
    }
}

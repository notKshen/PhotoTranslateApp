//
//  UpdateEditFormViewModel.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import UIKit

@Observable
class NewImageViewModel {
    var name: String = ""
    var translation: String?
    var data: Data?
    
    var cameraImage: UIImage?
    
    var image: UIImage {
        if let data, let uiImage = UIImage(data: data) {
            return uiImage
        } else {
            return Constants.placeholder
        }
    }
    
    var isDisabled: Bool {name.isEmpty}
}

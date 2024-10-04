//
//  Classifier.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-10-04.
//

import Foundation
import Vision
import CoreImage

class Classifier: ObservableObject {
    @Published var result:String?
    
    public func detect(ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: FastViTMA36F16(configuration: MLModelConfiguration()).model) else {return}
        
        let request = VNCoreMLRequest(model: model)
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        try? handler.perform([request])
        
        guard let results = request.results as? [VNClassificationObservation] else {return}
        
        if let firstResult = results.first {
            result = firstResult.identifier
        }
    }
}

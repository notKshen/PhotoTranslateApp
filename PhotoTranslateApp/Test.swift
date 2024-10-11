//
//  Test.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-10-07.
//

import Foundation
Task {
    let dataService = DataService()
    let translatedText = await dataService.getTranslation(for: "Hello, world!")
    print(translatedText)  // Output will be the translated text
}

//
//  PhotoTranslateApp.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import SwiftUI
import SwiftData

@main
struct Photo_Translate: App {
    var body: some Scene {
        WindowGroup {
            PhotosListView()
                .modelContainer(for: ImageModel.self)
        }
    }
}

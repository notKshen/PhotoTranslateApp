//
//  PreviewModifiers.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-30.
//

import SwiftUI
import SwiftData

struct MockData: PreviewModifier {
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
    
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try! ModelContainer(for: ImageModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(ImageModel(name: "sample 1"))
        container.mainContext.insert(ImageModel(name: "sample 2"))
        container.mainContext.insert(ImageModel(name: "sample 3"))
        return container
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mockData: Self = .modifier(MockData())
}

//
//  SampleView.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import SwiftUI
import SwiftData

struct ImageView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var image: ImageModel
    var body: some View {
        Form {
            VStack {
                Image(uiImage: image.image == nil ? Constants.placeholder : image.image!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.top, 10)
                
                VStack {
                    Text(image.name)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(image.translation ?? "translation")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .font(.title)
                

            }
            .cornerRadius(5)
        }
        .background() {
            Image("PastelBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview(traits: .mockData){
    @Previewable @Query var sample: [ImageModel]
    ImageView(image: sample[0])
}


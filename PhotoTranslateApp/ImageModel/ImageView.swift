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
        ZStack {
            VStack {
                Image(uiImage: image.image == nil ? Constants.placeholder : image.image!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.top, 15)
                    .padding(.horizontal, 15)
                
                VStack {
                    Text(image.name)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(image.translation ?? "translation")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .font(.title)
                

            }
            .background(Color.white)
            .cornerRadius(5)
            .padding()
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .center
            )
        .background() {
            Image("PastelBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview(traits: .mockData){
    @Previewable @Query var sample: [ImageModel]
    ImageView(image: sample[0])
}


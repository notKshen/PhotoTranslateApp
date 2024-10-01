//
//  SampleView.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import SwiftUI
import SwiftData

struct SampleView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var sample: SampleModel
    var body: some View {
        VStack {
            Text(sample.name)
                .font(.largeTitle)
            Image(uiImage: sample.image == nil ? Constants.placeholder : sample.image!)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
            HStack {
                Button("Delete", role: .destructive) {
                    modelContext.delete(sample)
                    try? modelContext.save()
                    dismiss()
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
        }
        .padding()
        .navigationTitle("Sample View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(traits: .mockData){
    @Previewable @Query var sample: [SampleModel]
    SampleView(sample: sample[0])
}


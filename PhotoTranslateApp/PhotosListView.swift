//
//  ContentView.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import SwiftUI
import SwiftData

struct PhotosListView: View {
    @Query var samples: [SampleModel]
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingSheet = false
    var body: some View {
        NavigationStack {
            Group {
                if samples.isEmpty {
                    ContentUnavailableView("Add your first photo", systemImage: "photo")
                } else {
                    List(samples) { sample in
                        NavigationLink(value: sample) {
                            HStack {
                                Image(uiImage: sample.image == nil ? Constants.placeholder : sample.image!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .padding(.trailing)
                                Text(sample.name)
                                    .font(.title)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(sample)
                                try? modelContext.save()
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationDestination(for: SampleModel.self) { sample in
                SampleView(sample: sample)
            }
            .navigationTitle("Collage")
            .toolbar {
                Button {
                    isShowingSheet.toggle()
                }label: {
                    Image(systemName: "plus.circle.fill")
                }
                .sheet(isPresented: $isShowingSheet) {
                    UpdateEditFormView(vm: UpdateEditFormViewModel())
                }
            }
        }
    }
}

#Preview(traits: .mockData){
    PhotosListView()
}

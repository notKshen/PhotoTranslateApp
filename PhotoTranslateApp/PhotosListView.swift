//
//  ContentView.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import SwiftUI
import SwiftData

struct PhotosListView: View {
    @Query(sort: \ImageModel.id, order: .reverse) var images: [ImageModel]
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingSheet = false
    var body: some View {
        NavigationStack {
            Group {
                // Empty Image View
                if images.isEmpty {
                    ContentUnavailableView("Add your first photo", systemImage: "photo")
                } else {
                    // List of Images
                    List(images) { sample in
                        NavigationLink(value: sample) {
                            HStack {
                                Image(uiImage: sample.image == nil ? Constants.placeholder : sample.image!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.trailing)
                                
                                Group {
                                    Text(sample.name)
                                    Text("-")
                                    Text(sample.translation ?? "Translation")
                                }
                                .font(.title2)
                                
                            }
                        }
                        // Swipe to delete
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(sample)
                                try? modelContext.save()
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
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
            // Nav Destination when an image is tapped
            .navigationDestination(for: ImageModel.self) { sample in
                ImageView(image: sample)
            }
            .navigationTitle("Collage")
            .toolbar {
                Button {
                    isShowingSheet.toggle()
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .tint(.accentColor)
                }
                .sheet(isPresented: $isShowingSheet) {
                    NewImageView(vm: NewImageViewModel())
                }
                
            }
        }
        .tint(.accentColor)
    }
}


#Preview(traits: .mockData){
    PhotosListView()
}

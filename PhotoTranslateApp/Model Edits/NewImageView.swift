//
//  UpdateEditFormView.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import SwiftUI
import SwiftData
import PhotosUI

struct NewImageView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var vm: NewImageViewModel
    @State private var imagePicker = ImagePicker()
    @State private var showCamera = false
    @State private var cameraError: CameraPermission.CameraError?
    var classifier = Classifier()
    var body: some View {
        NavigationStack {
            Form {
                VStack{
                    HStack {
                        // Camera and Photos button
                        Button("Camera", systemImage: "camera") {
                            if let error = CameraPermission.checkPermissions() {
                                cameraError = error
                            } else {
                                showCamera.toggle()
                            }
                        }
                        .alert(isPresented: .constant(cameraError != nil), error: cameraError) { _ in
                            Button("OK") {
                                cameraError = nil
                            }
                        } message: { error in
                            Text(error.recoverySuggestion ?? "Try again later")
                        }
                        .sheet(isPresented: $showCamera) {
                            UIKitCamera(selectedImage: $vm.cameraImage)
                                .ignoresSafeArea()
                        }
                        PhotosPicker(selection: $imagePicker.imageSelection) {
                            Label("Photos", systemImage: "photo")
                        }
                        // Call Image Classifier
                        .onChange(of: imagePicker.imageSelection, { oldValue, newValue in
                            Task {
                                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                    vm.data = data
                                    classifier.detect(ciImage: CIImage(data: data)!)
                                }
                            }
                        })
                        
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .buttonStyle(.borderedProminent)
                    // Image
                    Image(uiImage: vm.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                    // Classifier Result
                    if classifier.result != nil {
                        VStack(alignment: .leading){
                            // Format Classifier results
                            let name = classifier.result!
                            if let firstComma = name.firstIndex(of: ",") {
                                Text((String(name.prefix(upTo: firstComma)).capitalized))
                            } else {
                                Text(name.capitalized)
                            }
                        }
                        .padding()
                    }
                }
                .navigationBarBackButtonHidden()
            }
            .onAppear {
                imagePicker.setup(vm)
            }
            // Call Image Classifier
            .onChange(of: vm.cameraImage) {
                if let image = vm.cameraImage {
                    vm.data = image.jpegData(compressionQuality: 0.8)
                    if let data = vm.data, let ciImage = CIImage(data: data) {
                        classifier.detect(ciImage: ciImage)
                    }
                }
                
            }
            
            .toolbar {
                // Cancel Button
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                // Add Button
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Format Classifier results
                        let name = classifier.result!
                        if let firstComma = name.firstIndex(of: ",") {
                            vm.name = String(name.prefix(upTo: firstComma)).capitalized
                        } else {
                            vm.name = name.capitalized
                        }
                        // Create Model
                        let newSample = ImageModel(name: vm.name)
                        if vm.image != Constants.placeholder {
                            newSample.data = vm.image.jpegData(compressionQuality: 0.8)
                        } else {
                            newSample.data = nil
                        }
                        modelContext.insert(newSample)
                        dismiss()
                        
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
}

#Preview {
    NewImageView(vm: NewImageViewModel())
}

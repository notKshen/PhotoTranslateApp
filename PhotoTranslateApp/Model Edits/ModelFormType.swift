//
//  ModelFormType.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-09-23.
//

import SwiftUI

enum ModelFormType: Identifiable, View {
    case new
    case update(SampleModel)
    var id: String {
        String(describing: self)
    }
    var body: some View {
        switch self {
        case .new:
            UpdateEditFormView(vm: UpdateEditFormViewModel())
        case .update(let sample):
            UpdateEditFormView(vm: UpdateEditFormViewModel(sample: sample))
        }
    }
}

//
//  SwiftUIView.swift
//  PhotoTranslateApp
//
//  Created by Kobe Shen on 2024-10-04.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Image("PastelBackground")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    SwiftUIView()
}

//
//  LoadingButton.swift
//  MenuBarTranslator
//
//  Created by Aiur on 02.04.2021.
//

import SwiftUI

struct LoadingButton: View {
    
    let text: String
    @Binding var isLoading: Bool
    let tapAction: (() -> ())
    
    var body: some View {
        HStack {
            if isLoading {
                if #available(OSX 11.0, *) {
                    ProgressView()
                        .frame(width: 25, height: 5)
                        .scaleEffect(0.5)
                } else {
                    Text("Loading...")
                }
            }
            Button(text) {
                tapAction()
            }
        }
    }
}

struct LoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButton(text: "Save", isLoading: Binding<Bool>.constant(true)) {
            print("trying loading smth good :)")
        }
    }
}

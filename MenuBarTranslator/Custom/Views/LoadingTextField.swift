//
//  LoadingTextField.swift
//  MenuBarTranslator
//
//  Created by Aiur on 09.12.2020.
//

import SwiftUI

struct LoadingTextField: View {
    
    var fieldPlaceholder: String = ""
    @State var fieldValue: String = ""
    @State var loading: Bool = false
    
    var body: some View {
        HStack {
            TextField(fieldPlaceholder, text: $fieldValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if #available(OSX 11.0, *) {
                if loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct LoadingTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoadingTextField()
    }
}

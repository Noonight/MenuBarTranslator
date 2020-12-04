//
//  TranslationView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI

struct TranslationView: View {
    @ObservedObject var viewModel = TranslationViewModel()
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text("From").font(.title)
                EnRuToggleButtonsView(pickedLanguage: self.$viewModel.fromLanguage)
                    .frame(height: 50)
            }
            
            HStack {
                TextField("Target:", text: self.$viewModel.fromText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("To:", text: self.$viewModel.translation.text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }.padding()
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
    }
}

//
//  TranslationView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI

struct TranslationView: View {
    @StateObject var viewModel = TranslationViewModel()
    
    var body: some View {
        VStack(spacing: 6) {
            VStack(alignment: .leading) {
                HStack {
                    Text("From")
                        .font(.title)
                        .foregroundColor(Color("TitleText"))
                    Spacer()
                    Group {
                        loadingView
                        saveButton
                    }
                }
                EnRuToggleButtonsView(pickedLanguage: self.$viewModel.fromLanguage)
                    .frame(height: 30)
            }
            
            translationView
        }
        .padding([.leading, .bottom, .trailing], 6)
    }
    
    @ViewBuilder var loadingView: some View {
        if viewModel.loading {
            if #available(OSX 11.0, *) {
                ProgressView()
                    .frame(width: 5, height: 5)
                    .scaleEffect(0.5)
            } else {
                Text("Translating ...")
            }
        }
    }
    
    @ViewBuilder var saveButton: some View {
        if !viewModel.loading && viewModel.translation.text.count >= 1 {
            Spacer()
            LoadingButton(text: "Save", isLoading: $viewModel.loading) {
                viewModel.saveWord()
            }
        }
    }
    
    @ViewBuilder var translationView: some View {
        HStack {
            TextEditor(text: self.$viewModel.fromText)
                .font(.system(size: 17, weight: .light, design: Font.Design.rounded))
                .cornerRadius(5)
                .frame(type: .wide)
            
            TextEditor(text: self.$viewModel.translation.text)
                .font(.system(size: 17, weight: .thin, design: Font.Design.rounded))
                .cornerRadius(5)
                .frame(type: .wide)
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
    }
}

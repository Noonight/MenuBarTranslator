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
            TextView(text: self.$viewModel.fromText, isFirstResponder: true, textColor: Color("TranslateText"))
                .padding([.top, .bottom], 6)
                .background(Color("TranslateBackground"))
                .cornerRadius(5)
                .onAppear {
                    self.viewModel.clearTranslationFields()
                }

            TextView(text: self.$viewModel.translation.text, textColor: Color("TranslateText"))
                .padding([.top, .bottom], 6)
            
//            TextEditor(text: self.$viewModel.fromText)
//                .padding([.top, .bottom], 6)
//                .background(Color.secondary)
//                .cornerRadius(5)
//                .foregroundColor(.black)
//                .frame(type: .wide)
//            VStack(alignment: .leading, spacing: 0) {
//                Text(viewModel.translation.text)
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    .background(Color.red)
//                    .multilineTextAlignment(.leading)
//                    .padding([.top, .bottom], 6)
//
//                Spacer()
//            }
//            .frame(type: .wide)
            
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
    }
}

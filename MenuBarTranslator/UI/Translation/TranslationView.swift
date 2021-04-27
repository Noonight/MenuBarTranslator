//
//  TranslationView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI
import Introspect

struct TranslationView: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var viewModel = TranslationViewModel()
    
    var body: some View {
        VStack(spacing: 6) {
            VStack(alignment: .leading) {
                HStack {
                    Text("From")
                        .font(.title)
                        .foregroundColor(.white)
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
            TextView(text: self.$viewModel.fromText, isFirstResponder: true, textColor: .black)
                .padding([.top, .bottom], 6)
                .background(Color.secondary)
                .cornerRadius(5)
            
            TextView(text: self.$viewModel.translation.text, textColor: nil)
                .padding([.top, .bottom], 6)
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
    }
}

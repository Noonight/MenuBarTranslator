//
//  MainView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var translationViewModel: TranslationViewModel
    
    var body: some View {
        TabView {
            TranslationView()
                .tabItem { Text("Translation") }
                .environmentObject(translationViewModel)
            
            DictionaryView()
                .tabItem { Text("Dictionary") }
        }
        .padding(.top, 6)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


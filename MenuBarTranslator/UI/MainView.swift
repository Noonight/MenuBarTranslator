//
//  MainView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            TranslationView()
                .tabItem { Text("Translation") }
            
            DictionaryView()
                .tabItem { Text("Dictionary") }
        }
        .accentColor(.accentColor)
        .padding(.top, 6)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


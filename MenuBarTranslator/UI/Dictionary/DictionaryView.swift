//
//  DictionaryView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI
import CoreData

struct DictionaryView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var savedWords: [SavedTranslates] = [
        SavedTranslates(ru: "Привет", en: "Hello"),
        SavedTranslates(ru: "Пока", en: "Bye"),
        SavedTranslates(ru: "Доброе утро", en: "Good morning"),
        SavedTranslates(ru: "Действие", en: "Action")
    ]
    
    var body: some View {
        List {
            HStack {
                Text("en")
                Spacer()
                Text("ру")
            }
            ForEach(savedWords) { (translation: SavedTranslates) in
                HStack {
                    Text(translation.en)
                        .background(Color.red)
                    Spacer()
                    Text(translation.ru)
                        .background(Color.blue)
                }
            }
        }
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}

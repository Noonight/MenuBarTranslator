//
//  EnRuToggleButtonsView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI

struct EnRuToggleButtonsView: View {
    
    @Binding var pickedLanguage: Language
    
    @State private var en: Bool = false
    @State private var ru: Bool = false
    
    var body: some View {
        HStack(spacing: 6) {
            ToggleButtonView(title: "English", toggle: $en) { isTapped in
                if isTapped {
                    pickedLanguage = Language.en
                    ru = false
                }
            }
            ToggleButtonView(title: "Russian", toggle: $ru) { isTapped in
                if isTapped {
                    pickedLanguage = Language.ru
                    en = false
                }
            }
        }
        .onAppear {
            switch self.pickedLanguage {
            case .en:
                self.en = true
                self.ru = false
            case .ru:
                self.ru = true
                self.en = false
            }
        }
    }
    
    init(pickedLanguage: Binding<Language>) {
        self._pickedLanguage = pickedLanguage
    }
}

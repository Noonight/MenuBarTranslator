//
//  TextDictionaryTitleStyle.swift
//  MenuBarTranslator
//
//  Created by Aiur on 07.04.2021.
//

import SwiftUI

extension Text {
    func dictionaryHeaderStyle() -> some View {
        self
        .frame(type: .full)
        .padding([.leading, .trailing], 8)
        .padding([.top, .bottom], 4)
        .background(Color.accentColor)
        .cornerRadius(5)
    }
}

//
//  BlueButtonStyle.swift
//  FirstMenuBarApp
//
//  Created by Aiur on 26.11.2020.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .contentShape(RoundedRectangle(cornerRadius: 15))
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue)
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.accentColor)
                    }
                }
            )
    }
}

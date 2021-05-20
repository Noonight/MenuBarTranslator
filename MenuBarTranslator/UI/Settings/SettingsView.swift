//
//  SettingsView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 20.05.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State var apiAddress: String = ""
    @State var lightBackground: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("API Address :")
                TextField("", text: $apiAddress)
            }
            
            Toggle("LightBackgorund", isOn: $lightBackground)
            
            Divider()
            
            HStack {
                Spacer()
                Button("Cancel") {
                    
                }
                Button("Save") {
                    
                }
            }
        }
        .padding()
        .background(lightBackground ? Color.secondary : nil)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

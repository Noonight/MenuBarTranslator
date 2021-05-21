//
//  SettingsView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 20.05.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("API Address")
                TextField("", text: $viewModel.apiAddress)
            }
            Form {
                DisclosureGroup("Default addresses") {
                    Picker("", selection: $viewModel.apiPicker.animation()) {
                        ForEach(DefaultApiAddresses.allCases, id: \.self) { (value: DefaultApiAddresses) in
                            Text(value.rawValue).tag(value)
                        }
                    }
                }
            }
            
            Spacer()

            Divider()
            
            HStack {
                Spacer()
                Button("Cancel") {
                    viewModel.cancelChanges()
                }
                Button("Save") {
                    viewModel.saveChanges()
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

//
//  ToggleButtonView.swift
//  FirstMenuBarApp
//
//  Created by Aiur on 26.11.2020.
//

import SwiftUI

struct ToggleButtonView: View {
    
    let title: String
    @Binding var toggle: Bool
    let tap: ((Bool) -> ())? // capture current state
    
    var body: some View {
        if toggle {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.blue)
                .overlay(Text(title).foregroundColor(.white))
                .onTapGesture {
                    if toggle {
                        if let tap = tap {
                            tap(toggle)
                        }
                    } else {
                        toggle.toggle()
                        if let tap = tap {
                            tap(toggle)
                        }
                    }
                }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(nil)
                    .shadow(color: .gray, radius: 5, x: 0.0, y: 0.0)
                Text(title).foregroundColor(.black)
            }
            .onTapGesture {
                if toggle {
                    if let tap = tap {
                        tap(toggle)
                    }
                } else {
                    toggle.toggle()
                    if let tap = tap {
                        tap(toggle)
                    }
                }
            }
        }
    }
}

struct ToggleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ToggleButtonView(title: "Tap it 1", toggle: Binding<Bool>.constant(true)) { _ in}
                .padding()
            ToggleButtonView(title: "Tap it 2", toggle: Binding<Bool>.constant(false)) { _ in}
                .padding()
        }
        .background(Color.gray)
        .padding()
        
    }
}

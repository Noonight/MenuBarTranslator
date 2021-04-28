//
//  SavedWord.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.04.2021.
//

import Foundation
import SwiftUI

struct WordView: View {
    
    @StateObject var viewModel = WordViewModel()
    
    @Binding var isShown: Bool
    
    var body: some View {
        VStack {
            words
            Spacer()
            Divider().background(Color.white)
            manageButtons
        }
        .frame(width: 300, height: 100)
        .padding()
    }
    
    @ViewBuilder var words: some View {
        HStack {
            Text(viewModel.word?.en ?? "en")
                .frame(type: .wide)
                .foregroundColor(.white)
            Text(viewModel.word?.ru ?? "ру")
                .frame(type: .wide)
                .foregroundColor(.white)
            
        }
    }
    
    var manageButtons: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isShown = false
                }, label: {
                    Image(systemName: "chevron.backward.circle.fill")
                        .foregroundColor(.white)
                })
            }
            HStack {
                
                repeatCounter
                
                Spacer()
                
                date
                
                Spacer()
                    
                Button(action: {
                    
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    
                }) {
                    Image(systemName: "trash.circle.fill")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    var repeatCounter: some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundColor(.white)
            }
            Text("\(String(viewModel.word?.repeatCounter ?? 0))")
                .foregroundColor(.white)
                .frame(minWidth: 6, maxWidth: 22)
                .overlay(Rectangle().fill(Color.gray).frame(type: .full))
            
            
            Button(action: {
                
            }) {
                Image(systemName: "chevron.up.circle.fill")
                    .foregroundColor(.white)
            }
        }
    }
    
    @ViewBuilder var date: some View {
        Text("\(DateHelper.format(date: viewModel.word?.lastRepeatDate ?? Date()))")
            .foregroundColor(.white)
        
    }
}

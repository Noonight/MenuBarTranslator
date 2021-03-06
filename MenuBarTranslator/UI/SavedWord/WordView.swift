//
//  SavedWord.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.04.2021.
//

import Foundation
import SwiftUI

protocol WordViewCloseDelegate {
    func close()
}

struct WordView: View {
    
    @ObservedObject var viewModel: WordViewModel
    
    @Binding var isShown: Bool
    
    @State private var flag = false
    
    let wordViewCloseDelegate: WordViewCloseDelegate
    
    var body: some View {
        // MARK: - FIXED
        /*
         ERROR: Setting <_TtGC7SwiftUI13NSHostingViewVS_7AnyView_: 0x7fd8111b8a00> as the first responder for window <_NSPopoverWindow: 0x7fd80fdb7350>, but it is in a different window ((null))! This would eventually crash when the view is freed. The first responder will be set to nil.
         
         SOLUTION from: https://swiftui-lab.com/working-with-focus-on-swiftui-views/
         */
         
        Group {
            if !flag {
                Color.clear.onAppear {
                    self.flag = true
                }
            } else {
                VStack {
                    words
                    Spacer()
                    Divider().background(Color("TranslateIn"))
                    manageButtons
                }
                .frame(width: 300, height: 100)
                .padding()
            }
        }.onDisappear {
            close()
        }
    }
    
    @ViewBuilder var words: some View {
        HStack {
            Text(viewModel.word?.en ?? "en")
                .frame(type: .wide)
                .frame(alignment: .topLeading)
                .foregroundColor(Color("TranslateText"))
            Text(viewModel.word?.ru ?? "ру")
                .frame(type: .wide)
                .frame(alignment: .topLeading)
                .foregroundColor(Color("TranslateText"))
            
        }
    }
    
    var manageButtons: some View {
        HStack {
            
            repeatCounter
            
            Spacer()
            
            date
            
            Spacer()
            
            Button(action: {
                close()
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color("TranslateIn"))
            }
            
            Button(action: {
                viewModel.deleteWord()
                close()
            }) {
                Image(systemName: "trash.circle.fill")
                    .foregroundColor(Color("TranslateIn"))
            }
        }
    }
    
    var repeatCounter: some View {
        HStack {
            Button(action: {
                viewModel.decreaseRepeatCounter()
            }) {
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundColor(Color("TranslateIn"))
            }
            Text("\(String(viewModel.word?.repeatCounter ?? 0))")
                .foregroundColor(Color("TranslateText"))
                .frame(minWidth: 6, maxWidth: 22)
            
            Button(action: {
                viewModel.increaseRepeatCounter()
            }) {
                Image(systemName: "chevron.up.circle.fill")
                    .foregroundColor(Color("TranslateIn"))
            }
        }
    }
    
    @ViewBuilder var date: some View {
        Text("\(DateHelper.format(date: viewModel.word?.lastRepeatDate ?? Date()))")
            .foregroundColor(Color("TranslateText"))
        
    }
}

extension WordView {
    func close() {
        wordViewCloseDelegate.close()
        isShown = false
    }
}

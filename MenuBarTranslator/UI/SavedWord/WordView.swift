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
                    Divider().background(Color.white)
                    manageButtons
                }
                .frame(width: 300, height: 100)
                .padding()
            }
        }
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
                    close()
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
                    viewModel.updateWord()
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    viewModel.deleteWord()
                    close()
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
                viewModel.decreaseRepeatCounter()
            }) {
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundColor(.white)
            }
            Text("\(String(viewModel.word?.repeatCounter ?? 0))")
                .foregroundColor(.white)
                .frame(minWidth: 6, maxWidth: 22)
            
            Button(action: {
                viewModel.increaseRepeatCounter()
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

extension WordView {
    func close() {
        wordViewCloseDelegate.close()
        isShown = false
    }
}

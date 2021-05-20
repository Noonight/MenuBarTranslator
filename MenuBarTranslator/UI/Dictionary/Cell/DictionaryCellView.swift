//
//  DictionaryCellView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 02.04.2021.
//

import SwiftUI

protocol DictionaryCellProtocol {
    func updateBtn(word: SavedWord)
    func deleteBtn(word: SavedWord)
    func increaseBtn(word: SavedWord)
    func decreaseBtn(word: SavedWord)
}

struct DictionaryCellView: View {
    
    let savedWord: SavedWord
    
    let cellDelegate: DictionaryCellProtocol
    
    @State var showSheet: Bool = false
    
    let wordViewCloseDelegate: WordViewCloseDelegate
    
    var body: some View {
        
        VStack {
            
            words
            
            Divider()
                .background(Color("TranslateIn"))
            
            manageBtns
        }
        .padding(4)
        .background(Color("TranslateBackground"))
        .cornerRadius(5)
    }
    
    var words: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(savedWord.en)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .foregroundColor(Color("TranslateText"))
            Spacer()
            Text(savedWord.ru)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .foregroundColor(Color("TranslateText"))
        }
    }
    
    var manageBtns: some View {
        HStack {
            
            repeatCounter
            
            Spacer()
            
            date
            
            Spacer()
            
            Button(action: {
                cellDelegate.updateBtn(word: savedWord)
                showSheet.toggle()
            }) {
                Image(systemName: "pencil.circle.fill")
                    .foregroundColor(Color("TranslateIn"))
            }
            .popover(isPresented: $showSheet) {
                goToWordView()
//                WordView(viewModel: WordViewModel(), isShown: $showSheet)
            }
            
            Button(action: {
                cellDelegate.deleteBtn(word: savedWord)
            }) {
                Image(systemName: "trash.circle.fill")
                    .foregroundColor(Color("TranslateIn"))
            }
        }
    }
    
    var repeatCounter: some View {
        HStack {
            Button(action: {
                cellDelegate.decreaseBtn(word: savedWord)
            }) {
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundColor(Color("TranslateIn"))
            }
            Text("\(String(savedWord.repeatCounter))")
                .foregroundColor(Color("TranslateText"))
                .frame(minWidth: 6, maxWidth: 22)
            Button(action: {
                cellDelegate.increaseBtn(word: savedWord)
            }) {
                Image(systemName: "chevron.up.circle.fill")
                    .foregroundColor(Color("TranslateIn"))
            }
        }
    }
    
    @ViewBuilder var date: some View {
        if let lastDate = savedWord.lastRepeatDate {
            Text("\(DateHelper.format(date: lastDate))")
                .foregroundColor(Color("TranslateText"))
        }
    }
    
    func goToWordView() -> some View {
        let viewModel = WordViewModel()
        viewModel.word = savedWord
        return WordView(viewModel: viewModel, isShown: $showSheet, wordViewCloseDelegate: wordViewCloseDelegate)
    }
}

struct DictionaryCellView_Previews: PreviewProvider {
    static var previews: some View {
        //        DictionaryCellView()
        Text("empty")
    }
}

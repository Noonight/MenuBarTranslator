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
    
    var body: some View {
        VStack {
            
            words
            
            Divider()
                .background(Color.black)
            
            manageBtns
        }
        .padding(4)
        .background(Color.secondary)
        .cornerRadius(5)
        //        .contextMenu {
        //            Text("Hello from context")
        //        }
    }
    
    var words: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(savedWord.en)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .foregroundColor(.black)
            Spacer()
            Text(savedWord.ru)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .foregroundColor(.black)
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
                    .foregroundColor(.black)
            }
            .popover(isPresented: $showSheet) {
                WordView(isShown: $showSheet)
            }
            
            Button(action: {
                cellDelegate.deleteBtn(word: savedWord)
            }) {
                Image(systemName: "trash.circle.fill")
                    .foregroundColor(.black)
            }
        }
    }
    
    var repeatCounter: some View {
        HStack {
            Button(action: {
                cellDelegate.decreaseBtn(word: savedWord)
            }) {
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundColor(.black)
            }
            Text("\(String(savedWord.repeatCounter))")
                .foregroundColor(.black)
                .frame(minWidth: 6, maxWidth: 22)
            Button(action: {
                cellDelegate.increaseBtn(word: savedWord)
            }) {
                Image(systemName: "chevron.up.circle.fill")
                    .foregroundColor(.black)
            }
        }
    }
    
    @ViewBuilder var date: some View {
        if let lastDate = savedWord.lastRepeatDate {
            Text("\(DateHelper.format(date: lastDate))")
                .foregroundColor(.black)
        }
    }
}

struct DictionaryCellView_Previews: PreviewProvider {
    static var previews: some View {
        //        DictionaryCellView()
        Text("empty")
    }
}

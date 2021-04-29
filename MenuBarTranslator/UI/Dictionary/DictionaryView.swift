//
//  DictionaryView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI
import CoreData

struct DictionaryView: View {
    
    @StateObject var viewModel = DictionaryViewModel()
    
    @State var selection: SavedWord? = nil
    
    var body: some View {
        ZStack {
            emptyState
            VStack {
                header
                
                list
            }
        }
        .padding([.leading, .bottom, .trailing], 6)
        .onAppear {
            viewModel.onAppear()
        }
        
    }
    
    var header: some View {
        HStack(spacing: 4) {
            Text("en")
                .dictionaryHeaderStyle()
            Text("ru")
                .dictionaryHeaderStyle()
        }
        .frame(type: .wide)
        .frame(height: 25)
    }
    
    var list: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.savedWords) { (savedWord: SavedWord) in
                    DictionaryCellView(savedWord: savedWord, cellDelegate: self, wordViewCloseDelegate: self)
                }
//                .onDeleteCommand {
//                    viewModel.deleteWord(selection)
//                }
            }
        }
    }
    
    @ViewBuilder var emptyState: some View {
        if viewModel.savedWords.count == 0 {
            VStack(alignment: .center) {
                Image(systemName: "moon.stars.fill")
                Text("You don't have any saved words yet")
            }
        }
    }
}

// MARK: - DictionaryCellProtocol / Delegate

extension DictionaryView: DictionaryCellProtocol {
    func updateBtn(word: SavedWord) {
        // open next window
    }
    
    func deleteBtn(word: SavedWord) {
        viewModel.deleteWord(word)
    }
    
    func increaseBtn(word: SavedWord) {
        viewModel.increaseRepeatCounter(for: word)
    }
    
    func decreaseBtn(word: SavedWord) {
        viewModel.decreaseRepeatCounter(for: word)
    }
}

// MARK: - WordViewCloseDelegate

extension DictionaryView: WordViewCloseDelegate {
    func close() {
        viewModel.fetchWords()
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}

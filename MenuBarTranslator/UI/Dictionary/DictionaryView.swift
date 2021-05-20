//
//  DictionaryView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import SwiftUI

struct DictionaryView: View {
    
    @StateObject var viewModel = DictionaryViewModel()
    
    var body: some View {
        ZStack {
            emptyState
            VStack {
//                header
                
                search
                filter
                
                list
            }
        }
        .padding([.leading, .bottom, .trailing], 6)
        .onAppear {
            viewModel.onAppear()
        }
        
    }
    
    var search: some View {
        TextField("Search: ", text: $viewModel.searchField)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    var filter: some View {
        Picker(selection: $viewModel.sortOption,
               label: Image(systemName: "line.horizontal.3.decrease.circle.fill")
                .foregroundColor(.blue)
        ) {
            ForEach(SortOption.allCases, id: \.self) { view in
                Text(view.rawValue).tag(view)
            }
        }
    }
    
    var list: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.savedWords) { (savedWord: SavedWord) in
                    DictionaryCellView(savedWord: savedWord, cellDelegate: self, wordViewCloseDelegate: self)
                }
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

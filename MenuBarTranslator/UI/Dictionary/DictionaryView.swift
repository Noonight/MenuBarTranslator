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
        VStack {
            header
            
            list
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
                    DictionaryCellView(
                        savedWord: savedWord,
                        updateBtnAction: {
                            
                        }, deleteBtnAction: {
                            
                        })
                }
                .onDeleteCommand {
                    viewModel.deleteSelectedWord(selection)
                }
            }
        }
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}

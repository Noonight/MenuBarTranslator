//
//  DictionaryViewModel.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.03.2021.
//

import Foundation
import Combine

protocol DictionaryViewModelProtocol {
    var savedWords: [SavedWord] { get }
    func fetchWords()
    func deleteSelectedWord(_ word: SavedWord?)
    func onAppear()
}

final class DictionaryViewModel: ObservableObject {
    @Published var savedWords: [SavedWord] = [SavedWord]()
    
    var coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreDataService = coreDataService
    }
}

extension DictionaryViewModel: DictionaryViewModelProtocol {
    func onAppear() {
        fetchWords()
    }
    
    func fetchWords() {
        savedWords = coreDataService.fetchWordList()
    }
    
    func deleteSelectedWord(_ word: SavedWord?) {
        if let selectedWord = word {
            if let index = savedWords.firstIndex(of: selectedWord) {
                savedWords.remove(at: index)
            }
            coreDataService.deleteWord(savedWord: selectedWord)
        }
    }
}

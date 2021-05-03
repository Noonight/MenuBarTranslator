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
    var sortOption: SortOption { get set }
    func fetchWords()
    func deleteWord(_ word: SavedWord)
    func onAppear()
    func increaseRepeatCounter(for word: SavedWord)
    func decreaseRepeatCounter(for word: SavedWord)
}

final class DictionaryViewModel: ObservableObject {
    @Published var savedWords: [SavedWord] = [SavedWord]()
    @Published var sortOption: SortOption = .relevance
    
    var coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreDataService = coreDataService
    }
}

extension DictionaryViewModel: DictionaryViewModelProtocol {
    func increaseRepeatCounter(for word: SavedWord) {
        coreDataService.increaseRepeat(for: word)
        fetchWords()
    }
    
    func decreaseRepeatCounter(for word: SavedWord) {
        coreDataService.decreaseRepeat(for: word)
        fetchWords()
    }
    
    func onAppear() {
        fetchWords()
    }
    
    func fetchWords() {
        savedWords = coreDataService.fetchWordList(sortBy: sortOption)
    }
    
    func deleteWord(_ word: SavedWord) {
        if let index = savedWords.firstIndex(of: word) {
            savedWords.remove(at: index)
        }
        coreDataService.deleteWord(savedWord: word)
    }
}

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
//    var searchField: String { get set }
    func fetchWords()
    func deleteWord(_ word: SavedWord)
    func onAppear()
    func increaseRepeatCounter(for word: SavedWord)
    func decreaseRepeatCounter(for word: SavedWord)
}

final class DictionaryViewModel: ObservableObject {
    @Published var savedWords: [SavedWord] = [SavedWord]()
    @Published var sortOption: SortOption = .relevance
    @Published var searchField: String = ""
    private var searchOption: String?
    
    private var coreDataService: CoreDataServiceProtocol

    private var cancellableSet: Set<AnyCancellable> = []
    
    init(coreDataService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreDataService = coreDataService
        
        /*
         Bad behaviour: Twice loaded words
            load on appear and on subscribing to $sortOption
         Solution: Use Defeered
            idk how ...
         */
        $sortOption
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.fetchWords()
            }
            .store(in: &cancellableSet)
        
        $searchField
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { value in
                if value.isEmpty {
                    self.searchOption = nil
                }
                if value.count > 0 {
                    self.searchOption = value
                }
                self.fetchWords()
            }
            .store(in: &cancellableSet)
        
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
        savedWords = coreDataService.fetchWordList(sortBy: sortOption, searchBy: searchOption)
    }
    
    func deleteWord(_ word: SavedWord) {
        if let index = savedWords.firstIndex(of: word) {
            savedWords.remove(at: index)
        }
        coreDataService.deleteWord(savedWord: word)
    }
}

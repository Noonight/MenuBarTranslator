//
//  WordViewModel.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.04.2021.
//

import Foundation

protocol WordViewModelProtocol {
    var word: SavedWord? { get set }
    func increaseRepeatCounter()
    func decreaseRepeatCounter()
    func updateWord()
    func deleteWord()
}

final class WordViewModel: ObservableObject {
    
    var coreDataService: CoreDataServiceProtocol
    
    @Published var word: SavedWord?
    
    init(coreDataService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreDataService = coreDataService
    }
}

extension WordViewModel: WordViewModelProtocol {
    func increaseRepeatCounter() {
        guard let word = word else { return }
        coreDataService.increaseRepeat(for: word)
    }
    
    func decreaseRepeatCounter() {
        guard let word = word else { return }
        coreDataService.decreaseRepeat(for: word)
    }
    
    func updateWord() {
        guard let word = word else { return }
        coreDataService.updateWord(word)
    }
    
    func deleteWord() {
        guard let word = word else { return }
        coreDataService.deleteWord(savedWord: word)
        // do some action for close window
    }
    
    
}

//
//  WordViewModel.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.04.2021.
//

import Foundation
import CoreData

protocol WordViewModelProtocol {
    var word: SavedWord? { get set }
    func increaseRepeatCounter()
    func decreaseRepeatCounter()
    func updateWord()
    func deleteWord()
    func updateViewData()
}

final class WordViewModel: ObservableObject {
    
    var coreDataService: CoreDataServiceProtocol
    
    @Published var word: SavedWord?
    
    init(coreDataService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreDataService = coreDataService
    }
}

extension WordViewModel: WordViewModelProtocol {
    internal func updateViewData() {
        guard let uuid = word?.id else { return }
        word = coreDataService.findByUUID(uuid: uuid)
    }
    
    func increaseRepeatCounter() {
        guard let word = word else { return }
        coreDataService.increaseRepeat(for: word)
        updateViewData()
    }
    
    func decreaseRepeatCounter() {
        guard let word = word else { return }
        coreDataService.decreaseRepeat(for: word)
        updateViewData()
    }
    
    func updateWord() {
        guard let word = word else { return }
        coreDataService.updateWord(word)
        updateViewData()
    }
    
    func deleteWord() {
        guard let word = word else { return }
        coreDataService.deleteWord(savedWord: word)
//        updateViewData()
        // do some action for close window
    }
    
    
}

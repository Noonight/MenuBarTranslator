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
//        let words = coreDataService.fetchWordList()
//        word = words.filter { (sw: SavedWord) in
//            sw.id! == self.word?.id!
//        }.first
//        if let unwrappedWord = self.word, let id = unwrappedWord.id {
//            self.word = self.coreDataService.findByUUID(uuid: id)
//        } else {
//            print("Word is nil")
//        }
        
        let helper = CoreDataHelper.shared.context
        let fetchRequest: NSFetchRequest<SavedWord> = SavedWord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", word!.id!.uuidString)
        fetchRequest.fetchLimit = 1
        do {
            let result = try helper.fetch(fetchRequest)
            let updatedWord = result.first
            self.word = updatedWord
        } catch {
            print("error")
        }
        // some error
//        let fetchedWord = CoreDataHelper.shared.fetchFirst(SavedWord.self, predicate: NSPredicate(format: "id = %@", word!.id!.uuidString))
//        switch fetchedWord {
//        case .success(let savedWord):
//            word = savedWord
//        case .failure(let error):
//            print("failure")
//        }
//        word = fetchedWord
        
//        coreDataService2.findByUUID(uuid: word!.id!) { (savedWord) in
//            self.word = savedWord
//            print(self.word)
//        }
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

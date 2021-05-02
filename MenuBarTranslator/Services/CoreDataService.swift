//
//  CoreDataService.swift
//  MenuBarTranslator
//
//  Created by Aiur on 25.04.2021.
//

import Foundation

protocol CoreDataServiceProtocol {
    func findByUUID(uuid: UUID) -> SavedWord?
    func fetchWordList() -> [SavedWord]
    func addWord(en: String, ru: String)
    func deleteWord(savedWord: SavedWord)
    func increaseRepeat(for word: SavedWord)
    func decreaseRepeat(for word: SavedWord)
    func updateWord(_ word: SavedWord)
}

class CoreDataService {
    static let shared: CoreDataServiceProtocol = CoreDataService()
    
    var coreDataHelper: CoreDataHelper = CoreDataHelper.shared
    
    private init() {}
}

// MARK: - CoreDataServiceProtocol

extension CoreDataService: CoreDataServiceProtocol {
    func updateWord(_ word: SavedWord) {
        coreDataHelper.update(word)
    }
    
    func increaseRepeat(for word: SavedWord) {
        let repeatedWord = word
        repeatedWord.repeatCounter += 1
        repeatedWord.lastRepeatDate = Date()
        coreDataHelper.update(repeatedWord)
    }
    
    func decreaseRepeat(for word: SavedWord) {
        let repeatedWord = word
        if repeatedWord.repeatCounter > 0 {
            repeatedWord.repeatCounter -= 1
        }
        repeatedWord.lastRepeatDate = Date()
        coreDataHelper.update(repeatedWord)
    }
    
    func findByUUID(uuid: UUID) -> SavedWord? {
        let result = coreDataHelper.fetchFirst(SavedWord.self, predicate: NSPredicate(format: "id = %@", uuid.uuidString))
        switch result {
        case .success(let savedWord):
            print(savedWord)
            return savedWord
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    func fetchWordList() -> [SavedWord] {
        let result: Result<[SavedWord], Error> = coreDataHelper.fetch(SavedWord.self)
        switch result {
        case .success(let savedWords):
            return savedWords
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addWord(en: String, ru: String) {
        let entity = SavedWord.entity()
        let newWord = SavedWord(entity: entity, insertInto: coreDataHelper.context)
        newWord.id = UUID()
        newWord.lastRepeatDate = Date()
        newWord.en = en
        newWord.ru = ru
        coreDataHelper.create(newWord)
    }
    
    func deleteWord(savedWord: SavedWord) {
        coreDataHelper.delete(savedWord)
    }
}

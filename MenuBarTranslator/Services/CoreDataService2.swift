//
//  CoreDataService2.swift
//  MenuBarTranslator
//
//  Created by Aiur on 01.05.2021.
//

import Foundation

protocol CoreDataService2Protocol {
    func findByUUID(uuid: UUID, closure: @escaping (SavedWord?) -> ())
    func fetchWordList(closure: @escaping ([SavedWord]) -> ())
    func addWord(en: String, ru: String, closure: @escaping (SavedWord) -> ())
    func deleteWord(savedWord: SavedWord, closure: @escaping (SavedWord) -> ())
    func increaseRepeat(for word: SavedWord, closure: @escaping (SavedWord) -> ())
    func decreaseRepeat(for word: SavedWord, closure: @escaping (SavedWord) -> ())
    func updateWord(_ word: SavedWord, closure: @escaping (SavedWord) -> ())
}

class CoreDataService2 {
    static let shared: CoreDataService2Protocol = CoreDataService2()
    
    var coreDataHelper: CoreDataHelper2 = CoreDataHelper2.shared
    
    private init() {}
}

// MARK: - CoreDataServiceProtocol

extension CoreDataService2: CoreDataService2Protocol {
    func findByUUID(uuid: UUID, closure: @escaping (SavedWord?) -> ()) {
        coreDataHelper.fetchFirst(SavedWord.self, predicate: NSPredicate(format: "id = %@", uuid.uuidString)) { (inResult: Result<SavedWord?, Error>) in
            switch inResult {
            case .success(let savedWord):
                closure(savedWord)
            case .failure(let error):
//                print("CoreDataService2, 37")
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchWordList(closure: @escaping ([SavedWord]) -> ()) {
        coreDataHelper.fetch(SavedWord.self) { (result: Result<[SavedWord], Error>) in
            switch result {
            case .success(let savedWords):
                closure(savedWords)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addWord(en: String, ru: String, closure: @escaping (SavedWord) -> ()) {
        let entity = SavedWord.entity()
        let newWord = SavedWord(entity: entity, insertInto: coreDataHelper.mainContext)
        newWord.id = UUID()
        newWord.lastRepeatDate = Date()
        newWord.en = en
        newWord.ru = ru
        coreDataHelper.create(newWord) { (result: Result<SavedWord, Error>) in
            switch result {
            case .success(let savedWord):
                closure(savedWord)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteWord(savedWord: SavedWord, closure: @escaping (SavedWord) -> ()) {
        coreDataHelper.delete(savedWord) { (result: Result<SavedWord, Error>) in
            switch result {
            case .success(let savedWord):
                closure(savedWord)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func increaseRepeat(for word: SavedWord, closure: @escaping (SavedWord) -> ()) {
        let repeatedWord = word
        repeatedWord.repeatCounter += 1
        repeatedWord.lastRepeatDate = Date()
        coreDataHelper.update(repeatedWord) { (result: Result<SavedWord, Error>) in
            switch result {
            case .success(let savedWord):
                closure(savedWord)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func decreaseRepeat(for word: SavedWord, closure: @escaping (SavedWord) -> ()) {
        let repeatedWord = word
        if repeatedWord.repeatCounter > 0 {
            repeatedWord.repeatCounter -= 1
        }
        repeatedWord.lastRepeatDate = Date()
        coreDataHelper.update(repeatedWord) { (result: Result<SavedWord, Error>) in
            switch result {
            case .success(let savedWord):
                closure(savedWord)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateWord(_ word: SavedWord, closure: @escaping (SavedWord) -> ()) {
        coreDataHelper.update(word) { (result: Result<SavedWord, Error>) in
            switch result {
            case .success(let savedWord):
                closure(savedWord)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

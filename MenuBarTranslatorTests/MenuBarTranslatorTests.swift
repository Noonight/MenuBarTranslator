//
//  MenuBarTranslatorTests.swift
//  MenuBarTranslatorTests
//
//  Created by Aiur on 28.04.2021.
//

import XCTest
import Foundation
@testable import MenuBarTranslator

class MenuBarTranslatorTests: XCTestCase {
    
    var words: [SavedWord]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        words = generateWords()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        words = generateWords()
        let randomWord = words.randomElement()!
        let word = SavedWord()
        word.id = UUID()
        word.en = "Hello"
        word.ru = "Привет"
        word.repeatCounter = 1
        word.lastRepeatDate = Date()
        
        print(words)
        
        words.updateElement(it: randomWord, to: word)
        
        print(words)
    }
    
    func generateWords() -> [SavedWord] {
        var words = [SavedWord]()
        let randomCapacity = Int.random(in: 5...100)
        for _ in 0...randomCapacity {
            var word = SavedWord()
            word.id = UUID()
            word.en = randomString(for: .en, length: Int.random(in: 2...10))
            word.ru = randomString(for: .ru, length: Int.random(in: 2...10))
            word.lastRepeatDate = Date()
            word.repeatCounter = Int64.random(in: 0...10)
            words.append(word)
        }
        return words
    }
    
    func randomString(for lang: Language,length: Int) -> String {
        var letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        switch lang {
        case .en:
            letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case .ru:
            letters = "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
        }
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

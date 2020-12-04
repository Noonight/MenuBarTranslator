//
//  TranslateModel.swift
//  MenuBarTranslator
//
//  Created by Aiur on 04.12.2020.
//

import Foundation

struct TranslateModel: Codable {
//    var id = UUID()
    
    var fromText: String = ""
    var text: String = ""
    var from: Language? = nil
    var to: Language? = nil
    
    static var placeholder: Self {
        return TranslateModel()
    }
}

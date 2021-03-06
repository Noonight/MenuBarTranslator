//
//  GoogleTranslateApi.swift
//  MenuBarTranslator
//
//  Created by Aiur on 04.12.2020.
//

import Foundation
import Combine

class GoogleTranslateApi {
    
    static let shared = GoogleTranslateApi()
    private let userDefaults = UserDefaultsHelper.shared
    private let baseURL = "http://noonight.savayer.space/translate"
//    private let baseURL = "http://0.0.0.0:4567/translate"
    
    private func absoluteURL(text: String, from: Language, to: Language) -> URL? {
        guard let url = URL(string: userDefaults.getAPIAddress() ?? baseURL) else { return nil }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "text", value: text),
            URLQueryItem(name: "from", value: from.rawValue),
            URLQueryItem(name: "to", value: to.rawValue)
        ]
        
        return urlComponents.url
    }
    
    func fetchTranslate(text: String, from: Language, to: Language) -> AnyPublisher<TranslateModel, Never> {
        
        guard let url = absoluteURL(text: text, from: from, to: to) else {
            return Just(TranslateModel.placeholder)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { return $0.data }
//            .print()
            .decode(type: TranslateModel.self, decoder: JSONDecoder())
//            .print()
            .catch { error in Just(TranslateModel.placeholder) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
}

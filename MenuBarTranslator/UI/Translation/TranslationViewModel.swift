//
//  TranslationViewModel.swift
//  MenuBarTranslator
//
//  Created by Aiur on 04.12.2020.
//

import Foundation
import Combine

final class TranslationViewModel: ObservableObject {
    // in
    @Published var fromText: String = ""
    @Published var fromLanguage: Language = .en
    // out
    @Published var translation = TranslateModel.placeholder
    
    init() {
        $fromText
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { [weak self] (text: String) -> AnyPublisher<TranslateModel, Never> in
                let from = self?.fromLanguage
                var to: Language
                if from == .en { to = .ru } else { to = .en }
                
                return GoogleTranslateApi
                    .shared
                    .fetchTranslate(
                        text: text,
                        from: from ?? .ru,
                        to: to )
            }
            .assign(to: \.translation, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
}

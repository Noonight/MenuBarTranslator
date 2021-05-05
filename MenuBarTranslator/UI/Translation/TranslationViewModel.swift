//
//  TranslationViewModel.swift
//  MenuBarTranslator
//
//  Created by Aiur on 04.12.2020.
//

import Foundation
import Combine

protocol TranslationViewModelProtocol {
    func saveWord()
}

final class TranslationViewModel: ObservableObject {
    // in
    @Published var fromText: String = ""
    @Published var fromLanguage: Language = .en
    // out
    @Published var translation = TranslateModel.placeholder
    @Published var loading: Bool = false
    @Published var error: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    var coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreDataService = coreDataService
        
        $fromLanguage
            .sink { (language: Language) in
                self.fromText.removeAll()
                self.translation = TranslateModel.placeholder
            }
            .store(in: &self.cancellableSet)
        
        $fromText
            .map { [weak self] text -> String in
                if text.isEmpty {
                    self?.translation = TranslateModel.placeholder
                }
                return text
            }
            .filter({ text -> Bool in
                text.count > 0
            })
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [weak self] text -> String in // bad try
                self?.loading.toggle()
                return text
            }
            .flatMap { [weak self] (text: String) -> AnyPublisher<TranslateModel, Never> in
                let from = self?.fromLanguage
                var to: Language
                if from == .en { to = .ru } else { to = .en }
                
                return GoogleTranslateApi
                    .shared
                    .fetchTranslate(
                        text: text,
                        from: from ?? .en,
                        to: to)
            }
            .sink(receiveCompletion: { [weak self] c in
                self?.loading = false
            }, receiveValue: { [weak self] translation in
                self?.translation = translation
                self?.loading = false
            })
            .store(in: &self.cancellableSet)
    }
}

extension TranslationViewModel: TranslationViewModelProtocol {
    func saveWord() {
        self.loading = true
        switch fromLanguage {
        case .en:
            coreDataService.addWord(en: fromText, ru: translation.text)
        case .ru:
            coreDataService.addWord(en: translation.text, ru: fromText)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.loading = false
        }
    }
}

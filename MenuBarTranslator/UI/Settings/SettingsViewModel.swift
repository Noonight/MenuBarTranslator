//
//  SettingsViewModel.swift
//  MenuBarTranslator
//
//  Created by Aiur on 21.05.2021.
//

import Foundation
import Combine

protocol SettingsViewModelProtocol {
    var apiAddress: String { get set }
    func onAppear()
    func fetchData()
    func saveChanges()
    func cancelChanges()
}

final class SettingsViewModel: ObservableObject {
    @Published var apiAddress: String = ""
    @Published var apiPicker: DefaultApiAddresses = .remote
    
    private let userDefaults: UserDefaultsHelperProtocol
    
    private var cancellableSet: Set<AnyCancellable> = []

    init(userDefaults: UserDefaultsHelperProtocol = UserDefaultsHelper()) {
        self.userDefaults = userDefaults
        $apiPicker
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.apiAddress = value.rawValue
            }
            .store(in: &cancellableSet)
    }
    
}

extension SettingsViewModel: SettingsViewModelProtocol {
    
    func onAppear() {
        fetchData()
    }
    
    func fetchData() {
        guard let address = userDefaults.getAPIAddress() else { return }
        apiAddress = address
    }
    
    func saveChanges() {
        if !apiAddress.isEmpty {
            userDefaults.setAPIAddress(apiAddress)
        }
    }
    
    func cancelChanges() {
        fetchData()
    }
}

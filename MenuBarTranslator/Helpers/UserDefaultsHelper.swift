//
//  UserDefaultsHelper.swift
//  MenuBarTranslator
//
//  Created by Aiur on 21.05.2021.
//

import Foundation

enum UserDefaultsKeys: String {
    case apiAddress = "APIAddress"
}

protocol UserDefaultsHelperProtocol {
    func getAPIAddress() -> String?
    func setAPIAddress(_ new: String)
}

final class UserDefaultsHelper {
    static let shared: UserDefaultsHelperProtocol = UserDefaultsHelper()
    
    private let defaults = UserDefaults.standard
}

extension UserDefaultsHelper: UserDefaultsHelperProtocol {
    func getAPIAddress() -> String? {
        return defaults.string(forKey: UserDefaultsKeys.apiAddress.rawValue)
    }
    
    func setAPIAddress(_ new: String) {
        defaults.setValue(new, forKey: UserDefaultsKeys.apiAddress.rawValue)
    }
    
    
}

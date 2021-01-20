//
//  Persistor.swift
//  NewsApp
//
//  Created by DIAKO on 1/19/21.
//

import Foundation

class Persistor {
    
    fileprivate var userDefaults:UserDefaults
    
    public let JWT_KEY:String = "JWT_KEY"
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    
    func getToken() -> String? {
        return userDefaults.string(forKey: JWT_KEY)
    }
    
    func save(token: String) {
        userDefaults.set(token, forKey: JWT_KEY)
    }
    
    func removeToken() {
        userDefaults.removeObject(forKey: JWT_KEY)
    }
}

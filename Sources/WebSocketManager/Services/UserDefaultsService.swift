//
//  File.swift
//  
//
//  Created by Maxim on 13.09.2022.
//



import Foundation

@propertyWrapper
    struct UserDefault<T: Codable> {
        let key: String
        let defaultValue: T

        init(_ key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }

        var wrappedValue: T {
            get {

                if let data = UserDefaults.standard.object(forKey: key) as? Data,
                    let user = try? JSONDecoder().decode(T.self, from: data) {
                    return user

                }

                return defaultValue
            }
            set {
                if let encoded = try? JSONEncoder().encode(newValue) {
                    UserDefaults.standard.set(encoded, forKey: key)
                }
            }
        }
    }

struct GlobalSettings {
    @UserDefault("food", defaultValue: []) var food: [FoodData]
    @UserDefault("cell", defaultValue: []) var cell: [Cell]
    
    func clearData() {
        UserDefaults.standard.removeObject(forKey: "food")
        UserDefaults.standard.removeObject(forKey: "cell")
    }
}

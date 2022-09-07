//
//  SettingsDefaults.swift
//  TestTask
//
//  Created by Евгений Ефимов on 03.09.2022.
//

import Foundation

protocol SettingsDefaultsProtocol {
    var valueFiltrBrands: String? { get set }
    var valueFiltrPriceMin: Int? { get set }
    var valueFiltrPriceMax: Int? { get set }
    var arrayBrands: [String] { get }
    var arrayСategories: [String] { get }
}

struct Price {
    var maxPrice = 10000
    var minPrice = 0
    var stepPrice = 100
}

private enum SettingKey: String {
    case brandName
    case priceMin
    case priceMax
}

private enum Сategories: String, CaseIterable {
    case Phones = "Phones"
    case Computer = "Computer"
    case Health = "Health"
    case Books = "Books"
}

private enum BrandsName: String, CaseIterable {
    case Samsung
    case Honor
    case Motorolla
}

final class SettingsDefaults: SettingsDefaultsProtocol {
    var arrayBrands: [String] {
        BrandsName.allCases.map {$0.rawValue}
    }
    
    var arrayСategories: [String] {
        Сategories.allCases.map { $0.rawValue }
    }
    
    var valueFiltrBrands: String? {
        get {
            return UserDefaults.standard.string(forKey: SettingKey.brandName.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.brandName.rawValue
            if let brand = newValue {
                defaults.set(brand, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    var valueFiltrPriceMin: Int? {
        get {
            return UserDefaults.standard.integer(forKey: SettingKey.priceMin.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.priceMin.rawValue
            if let price = newValue {
                defaults.set(price, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    var valueFiltrPriceMax: Int? {
        get {
            return UserDefaults.standard.integer(forKey: SettingKey.priceMax.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.priceMax.rawValue
            if let price = newValue {
                defaults.set(price, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}

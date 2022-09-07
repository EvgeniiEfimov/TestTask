//
//  FiltrInteractor.swift
//  TestTask
//
//  Created by Евгений Ефимов on 03.09.2022.
//

import Foundation

protocol FiltrInteractorProtocol: AnyObject {
    var getValueBrands: [String] { get }
    var getValueBrand: String { get set }
    var getValueMinPrice: Int { get set }
    var getValueMaxPrice: Int { get set }
}

final class FiltrInteractor: FiltrInteractorProtocol {
    
    
    weak var presenter: FiltrPresenterProtocol!
    var settingDefaults: SettingsDefaultsProtocol = SettingsDefaults()
    
    
    required init(presenter: FiltrPresenterProtocol) {
        self.presenter = presenter
    }
    
    var getValueBrands: [String] {
        settingDefaults.arrayBrands
    }
    
    var getValueBrand: String {
        get {
        settingDefaults.valueFiltrBrands ?? "-"
        }
        set {
            settingDefaults.valueFiltrBrands = newValue
        }
    }
    
    var getValueMinPrice: Int {
        get {
        settingDefaults.valueFiltrPriceMin ?? 0
        }
        set {
            settingDefaults.valueFiltrPriceMin = newValue
        }
    }
    
    var getValueMaxPrice: Int {
        get {
            settingDefaults.valueFiltrPriceMax ?? 0
        }
        set {
            settingDefaults.valueFiltrPriceMax = newValue
        }
    }

}

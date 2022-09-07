//
//  MainInteractor.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func getRequest()
    var getСategories: [String] { get }
}

final class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol!
    var networkService: NetworkServiceProtocol = NetworkService()
    var settingsDefaults: SettingsDefaultsProtocol = SettingsDefaults()
    
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }

    func getRequest() {
        networkService.requestAndParsJSON { data, arrayHomeImage, arrayBestImage  in
            self.presenter.networkData(data, arrayHomeImage, arrayBestImage)
        }
    }
    
    var getСategories: [String] {
        settingsDefaults.arrayСategories
    }
}

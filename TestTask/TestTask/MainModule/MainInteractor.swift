//
//  MainInteractor.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    var getData: Welcome? { get }
     
}

final class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol!
    var networkService: NetworkServiceProtocol = NetworkService()
    
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    var getData: Welcome? {
            return networkService.dataJSON

        
//        return networkService.dataJSON
//        return networkService.testGetData()
        
    }
}

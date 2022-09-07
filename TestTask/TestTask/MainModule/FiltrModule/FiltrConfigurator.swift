//
//  FiltrConfigurator.swift
//  TestTask
//
//  Created by Евгений Ефимов on 03.09.2022.
//

import Foundation

protocol FiltrConfiguratorProtocol: AnyObject {
    func configure(_ viewController: FiltrViewController)
}

final class FiltrConfigurator: FiltrConfiguratorProtocol {
    func configure(_ viewController: FiltrViewController) {
        let presenter = FiltrPresenter(view: viewController)
        let router = FiltrRouter(view: viewController)
        let interactor = FiltrInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    
}

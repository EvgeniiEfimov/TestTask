//
//  MainConfigurator.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import Foundation

protocol MainConfiguratorProtocol: AnyObject {
    func configure(_ viewController: MainViewController)
}

final class MainConfigurator: MainConfiguratorProtocol {
    func configure(_ viewController: MainViewController) {
        let presenter = MainPresenter(view: viewController)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    
}

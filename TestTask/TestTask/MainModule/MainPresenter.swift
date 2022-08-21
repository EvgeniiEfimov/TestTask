//
//  MainPresenter.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func configureVC()
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    func configureVC() {
        view.startConfig(interactor.getData)
    }
}

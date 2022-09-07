//
//  MainPresenter.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func configureVC()
    func networkData(_ data: Welcome, _ arrayHomeImage: [Data]?, _ arrayBestImage: [Data]?)
    func tapButtonFiltr()
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    func configureVC() {
        interactor.getRequest()
        view.arrayСategories = interactor.getСategories
    }
    
    func networkData(_ data: Welcome, _ arrayHomeImage: [Data]?, _ arrayBestImage: [Data]?) {
        view.startConfig(data, arrayHomeImage, arrayBestImage)
    }
    
    func tapButtonFiltr() {
        router.presentViewFiltr()
    }
}

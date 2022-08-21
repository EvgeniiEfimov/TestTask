//
//  MainRouter.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import Foundation

protocol MainRouterProtocol: AnyObject {
    
}

final class MainRouter: MainRouterProtocol {
    weak var view: MainViewProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
}

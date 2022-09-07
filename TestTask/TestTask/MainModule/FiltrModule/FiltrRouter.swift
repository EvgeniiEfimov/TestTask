//
//  FiltrRouter.swift
//  TestTask
//
//  Created by Евгений Ефимов on 03.09.2022.
//

import Foundation

protocol FiltrRouterProtocol: AnyObject {
    func dissmissView()
    
}

final class FiltrRouter: FiltrRouterProtocol {
    
    weak var view: FiltrViewControllerProtocol!
    
    required init(view: FiltrViewControllerProtocol) {
        self.view = view
    }
    
    func dissmissView() {
        view.dismissView()
    }
}

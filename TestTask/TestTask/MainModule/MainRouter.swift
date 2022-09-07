//
//  MainRouter.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import Foundation

protocol MainRouterProtocol: AnyObject {
    func presentViewFiltr()
    
}

final class MainRouter: MainRouterProtocol {
    weak var view: MainViewProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func presentViewFiltr() {
        
        let detailViewController = FiltrViewController()

        // 2
        if let sheet = detailViewController.sheetPresentationController {

            // 3
            sheet.detents = [.medium()]

        }
        // 4
        view.presents(detailViewController, animated: true)

    }
}

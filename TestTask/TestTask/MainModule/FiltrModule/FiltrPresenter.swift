//
//  FiltrPresenter.swift
//  TestTask
//
//  Created by Евгений Ефимов on 03.09.2022.
//

import Foundation

protocol FiltrPresenterProtocol: AnyObject {
    func startValueSelect()
    func clickButtonDone()
    func clickButtonExit()
}

final class FiltrPresenter: FiltrPresenterProtocol {
    weak var view: FiltrViewControllerProtocol!
    var interactor: FiltrInteractorProtocol!
    var router: FiltrRouterProtocol!
    
    
    required init(view: FiltrViewControllerProtocol) {
        self.view = view
    }
    
    func startValueSelect() {
        view.setPickerBrandsName(interactor.getValueBrands)
        view.selectBrand = interactor.getValueBrand
        view.selectPriceMin = interactor.getValueMinPrice
        view.selectPriceMax = interactor.getValueMaxPrice
    }
    
    func clickButtonDone() {
        interactor.getValueBrand = view.selectBrand
        interactor.getValueMinPrice = view.selectPriceMin
        interactor.getValueMaxPrice = view.selectPriceMax
        router.dissmissView()
    }
    
    func clickButtonExit() {
        router.dissmissView()
    }
    
    
    
}

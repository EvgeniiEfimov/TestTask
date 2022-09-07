//
//  FiltrViewController.swift
//  TestTask
//
//  Created by Евгений Ефимов on 31.08.2022.
//

import UIKit

protocol FiltrViewControllerProtocol: AnyObject {
    func setPickerBrandsName(_ brandsName: [String])
    var selectBrand: String { get set }
    var selectPriceMin: Int { get set }
    var selectPriceMax: Int { get set }
    func dismissView()
}

class FiltrViewController: UIViewController {
    @IBOutlet weak var textFieldBrand: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    
    var pickerBrands = UIPickerView()
    var pickerPrice = UIPickerView()
    var tapBarBrands = UIToolbar()
    var tapBarPrice = UIToolbar()
    var brandsName = [String]()
    var price = Price()
    var selectMinPrice = 0
    var selectMaxPrice = 0
    
    var presenter: FiltrPresenterProtocol!
    var configurator: FiltrConfiguratorProtocol = FiltrConfigurator()
    
    override func viewWillAppear(_ animated: Bool) {
        configurator.configure(self)
        presenter.startValueSelect()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerBrands.delegate = self
        pickerBrands.dataSource = self
        pickerPrice.delegate = self
        pickerPrice.dataSource = self
        getPickerView(textFieldBrand)
        getPickerView(textFieldPrice)
    }
    
    private func getPickerView(_ sender: UITextField) {
        let barItem: UIBarButtonItem
        if sender == textFieldBrand {
            sender.inputAccessoryView = tapBarBrands
            sender.inputView = pickerBrands
         barItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedPickerBrands))
            tapBarBrands.sizeToFit()
            tapBarBrands.setItems([barItem], animated: true)
        } else {
            sender.inputView = pickerPrice
            sender.inputAccessoryView = tapBarPrice
        barItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedPickerPrice))
            tapBarPrice.sizeToFit()
            tapBarPrice.setItems([barItem], animated: true)
        }
    }
    
    @objc func donePressedPickerBrands() {
        textFieldBrand.text = brandsName[pickerBrands.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    @objc func donePressedPickerPrice() {
        let step = price.stepPrice
        selectMinPrice = pickerPrice.selectedRow(inComponent: 0) * step
        selectMaxPrice = pickerPrice.selectedRow(inComponent: 1) * step
        textFieldPrice.text = "$" + "\(selectMinPrice)" + " - " + "$" + "\(selectMaxPrice)"
        self.view.endEditing(true)
    }
    
    @IBAction func buttonDone(_ sender: UIButton) {
        DispatchQueue.global(qos: .background).sync {
            self.presenter.clickButtonDone()
        }
    }
    
    @IBAction func buttonExit(_ sender: UIButton) {
        presenter.clickButtonExit()
    }
}

extension FiltrViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        var numberOfComponents = 1
        if pickerView == pickerPrice {
            numberOfComponents = 2
        }
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerBrands {
        return brandsName.count
        } else {
            return price.maxPrice / price.stepPrice
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerBrands {
        return brandsName[row]
        } else {
            return "\(price.minPrice + price.stepPrice * row)"
        }
    }
}

extension FiltrViewController: FiltrViewControllerProtocol {
    var selectPriceMin: Int {
        get {
            selectMinPrice
        }
        set {
            selectMinPrice = newValue
        }
    }
    
    var selectPriceMax: Int {
        get {
            selectMaxPrice
        }
        set {
            selectMaxPrice = newValue
            textFieldPrice.text = "$" + "\(selectMinPrice)" + " - " + "$" + "\(selectMaxPrice)"
        }
    }
    
    var selectBrand: String {
        get {
            textFieldBrand.text ?? " "
        }
        set {
            textFieldBrand.text = newValue
        }
    }
    
    func setPickerBrandsName(_ brandsName: [String]) {
        self.brandsName = brandsName
    }
    
    func dismissView() {
        dismiss(animated: true)
    }

}


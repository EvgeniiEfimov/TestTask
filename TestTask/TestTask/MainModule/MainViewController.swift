//
//  ViewController.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func startConfig(_ data: Welcome?)
}

final class MainViewController: UIViewController {

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var collectionViewHotSales: UICollectionView!
    @IBOutlet weak var collectionViewBestSeller: UICollectionView!
    @IBOutlet weak var buttonQRSerth: UIButton!
    @IBOutlet weak var textFieldSearthOutlet: UITextField!
    
    @IBOutlet weak var viewCell: UICollectionViewCell!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    let testArray = ["Phones", "Computer", "Health", "Books", "Phones", "Computer", "Health", "Books"]
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
//        presenter.configureVC()
        
        collectionViewOutlet.delegate = self
        collectionViewHotSales.delegate = self
        collectionViewOutlet.dataSource = self
        collectionViewHotSales.dataSource = self
        collectionViewBestSeller.delegate = self
        collectionViewBestSeller.dataSource = self
        
//        collectionViewOutlet.backgroundColor = UIColor.clear
//        collectionViewOutlet.contentInset.left = 30
        
        
        setStartView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        collectionViewOutlet.selectItem(at: .init(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    func setStartView() {
        collectionViewOutlet.backgroundColor = UIColor.clear
        collectionViewOutlet.contentInset.left = collectionViewOutlet.frame.width / 20

        buttonQRSerth.layer.cornerRadius = buttonQRSerth.frame.height / 2
        
        textFieldSearthOutlet.setLeftView(image: UIImage.init(named: "Search")!)
        textFieldSearthOutlet.tintColor = .darkGray
        textFieldSearthOutlet.isSecureTextEntry = true
        textFieldSearthOutlet.layer.cornerRadius = textFieldSearthOutlet.frame.height / 2
        textFieldSearthOutlet.layer.masksToBounds = true
        
        configureViewCell(collectionViewHotSales)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = Int()
        switch collectionView {
        case collectionViewOutlet:
            count = testArray.count
        case collectionViewHotSales:
            count = 4
        default:
            count = 4
        }
        return count
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         switch collectionView {
         case collectionViewOutlet:
             let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "selectCategory", for: indexPath) as! CollectionViewCell
             cell.imageViewCell.image = UIImage(named: "\(testArray[indexPath.item])")?.withRenderingMode(.alwaysTemplate)
             cell.labelCellOutlet.text = testArray[indexPath.item]
             cell.viewRound.layer.cornerRadius = cell.viewRound.frame.height / 2
             cell.viewRound.backgroundColor = UIColor.white
             if cell.isSelected == true {
                 cell.isSelected = true
             }
                 return cell
         case collectionViewHotSales:
             let cell = collectionViewHotSales.dequeueReusableCell(withReuseIdentifier: "cellHotSalesCollecton", for: indexPath) as! CollectionViewCellHotSales
             cell.imageViewHotSales.image = UIImage.init(named: "test")
             cell.viewContentCell.layer.cornerRadius = 15
             return cell
         default:
             let cell = collectionViewBestSeller.dequeueReusableCell(withReuseIdentifier: "cellBestSalesCollecton", for: indexPath) as! CollectionViewCellBestSales
             return cell
         }
    }
}



extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case collectionViewOutlet:
            return CGSize(width: collectionView.frame.width / 4 - 20, height: collectionView.frame.height)
        case collectionViewHotSales:
            return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height)
        default:
            return CGSize(width: collectionView.frame.width / 2 - 20, height: collectionView.frame.height)
        }
    }
}

extension MainViewController: MainViewProtocol {
    func startConfig(_ data: Welcome?) {
        
    }
}

extension MainViewController {
    func configureViewCell(_ collectionView: UICollectionView) {
        let cellPadding = 10.0
            let carouselLayout = UICollectionViewFlowLayout()
            carouselLayout.scrollDirection = .horizontal
    carouselLayout.sectionInset = .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
    carouselLayout.minimumLineSpacing = 20
            collectionView.collectionViewLayout = carouselLayout
    }
}





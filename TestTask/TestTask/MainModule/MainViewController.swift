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
    
    var data: Welcome!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        presenter.configureVC()
        
        collectionViewOutlet.delegate = self
        collectionViewHotSales.delegate = self
        collectionViewOutlet.dataSource = self
        collectionViewHotSales.dataSource = self
        collectionViewBestSeller.delegate = self
        collectionViewBestSeller.dataSource = self

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
        configureViewCellBestSeller(collectionViewBestSeller)
        
        
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
            count = data.homeStore.count
        default:
            count = data.bestSeller.count
        }
        return count
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         switch collectionView {
         case collectionViewOutlet:
             let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "selectCategory", for: indexPath) as! CollectionViewCell
             cell.imageViewCell.image = UIImage(named: "\(testArray[indexPath.item])")?.withRenderingMode(.alwaysTemplate)
             cell.labelCellOutlet.text = testArray[indexPath.item]
             DispatchQueue.main.async {
                 cell.viewRound.layer.cornerRadius = cell.viewRound.frame.width / 2
             }
             cell.viewRound.backgroundColor = UIColor.white
             if cell.isSelected == true {
                 cell.isSelected = true
             }
                 return cell
             
         case collectionViewHotSales:
             let cell = collectionViewHotSales.dequeueReusableCell(withReuseIdentifier: "cellHotSalesCollecton", for: indexPath) as! CollectionViewCellHotSales
             cell.imageViewHotSales.image = UIImage.init(named: "test")
             cell.viewContentCell.layer.cornerRadius = 15
             
             cell.imageNewCellHotSales.isHidden = data.homeStore[indexPath.item].isNew ?? true
             cell.labelModelCellHotSales.text = data.homeStore[indexPath.item].title
             cell.labelInfoCellHotSales.text = data.homeStore[indexPath.item].subtitle
             return cell
         default:
             let cell = collectionViewBestSeller.dequeueReusableCell(withReuseIdentifier: "cellBestSalesCollecton", for: indexPath) as! CollectionViewCellBestSales
             cell.imageViewModelCellBS.image = UIImage(named: "samsungTest")
             let imageFavorite = data.bestSeller[indexPath.item].isFavorites ?
             UIImage(named: "heart.fill") : UIImage(named: "heart")
             cell.buttonFavorite.setImage(imageFavorite, for: .normal)
             cell.labelFullPrice.text = "\(data.bestSeller[indexPath.item].discountPrice)"
             cell.labelPrice.text = "\(data.bestSeller[indexPath.item].priceWithoutDiscount)"
             cell.labelModel.text = "\(data.bestSeller[indexPath.item].title)"
             cell.layer.cornerRadius = 15
             cell.buttonFavorite.layer.cornerRadius = cell.buttonFavorite.frame.width/2
             cell.buttonFavorite.layer.masksToBounds = false
             cell.buttonFavorite.layer.shadowColor = UIColor.gray.cgColor
             cell.buttonFavorite.layer.shadowOffset = CGSize(width: 0, height: 0)
             cell.buttonFavorite.layer.shadowOpacity = 0.3
             cell.buttonFavorite.layer.shadowRadius = 6
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
            return CGSize(width: collectionView.frame.width / 2 - 15, height: collectionView.frame.height)
        }
    }
}

extension MainViewController: MainViewProtocol {
    func startConfig(_ data: Welcome?) {
        guard let getData = data else {
            return
        }
        self.data = getData
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
    
    func configureViewCellBestSeller(_ collectionView: UICollectionView) {
        let cellPadding = 10.0
            let carouselLayout = UICollectionViewFlowLayout()
            carouselLayout.scrollDirection = .horizontal
    carouselLayout.sectionInset = .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
    carouselLayout.minimumLineSpacing = 10
            collectionView.collectionViewLayout = carouselLayout
    }

}





//
//  ViewController.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func startConfig(_ data: Welcome?,  _ arrayHomeImage: [Data]?, _ arrayBestImage: [Data]?)
    func presents(_ viewControllerToPresent: UIViewController, animated flag: Bool)
    var arrayСategories: [String] { get set }
}

final class MainViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var splashImageOutlet: UIImageView!
    @IBOutlet weak var activitiOutlet: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var collectionViewHotSales: UICollectionView!
    @IBOutlet weak var collectionViewBestSeller: UICollectionView!
    @IBOutlet weak var buttonQRSerth: UIButton!
    @IBOutlet weak var textFieldSearthOutlet: UITextField!
    @IBOutlet weak var buttonFiltr: UIButton!
    
    @IBOutlet weak var filtrView: UIView!
    @IBOutlet weak var exitLabel: UIBarButtonItem!
    @IBOutlet weak var viewCell: UICollectionViewCell!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    var tapBar = UIToolbar()

    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    var categories: [String]!
    var arrayHomeImage: [Data]!
    var arrayBestImage: [Data]!
    var data: Welcome!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configurator.configure(self)
        presenter.configureVC()
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
    
    @IBAction func buttonFiltrAction(_ sender: UIButton) {
        presenter.tapButtonFiltr()
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
            count = arrayСategories.count
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
             cell.imageViewCell.image = UIImage(named: "\(arrayСategories[indexPath.item])")?.withRenderingMode(.alwaysTemplate)
             cell.labelCellOutlet.text = arrayСategories[indexPath.item]
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
             cell.imageViewHotSales.image = UIImage.init(data: arrayHomeImage[indexPath.item])
             cell.viewContentCell.layer.cornerRadius = 15
             
             cell.imageNewCellHotSales.isHidden = data.homeStore[indexPath.item].isNew ?? true
             cell.labelModelCellHotSales.text = data.homeStore[indexPath.item].title
             cell.labelInfoCellHotSales.text = data.homeStore[indexPath.item].subtitle
             return cell
             
         default:
             let cell = collectionViewBestSeller.dequeueReusableCell(withReuseIdentifier: "cellBestSalesCollecton", for: indexPath) as! CollectionViewCellBestSales
             cell.imageViewModelCellBS.image = UIImage(data: arrayBestImage[indexPath.item])
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
    var arrayСategories: [String] {
        get {
            categories
        }
        set {
            categories = newValue
        }
    }
    
    
    func presents(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func startConfig(_ data: Welcome?, _ arrayHomeImage: [Data]?, _ arrayBestImage: [Data]?) {
        
        guard let getData = data else {
            return
        }
        guard let homeImage = arrayHomeImage else {
            return
        }
        guard let bestImage = arrayBestImage else {
            return
        }
        
        DispatchQueue.main.async {
            self.arrayHomeImage = homeImage
            self.arrayBestImage = bestImage
            self.data = getData
            self.collectionViewOutlet.delegate = self
            self.collectionViewOutlet.dataSource = self
            self.collectionViewHotSales.delegate = self
            self.collectionViewHotSales.dataSource = self
            self.collectionViewBestSeller.delegate = self
            self.collectionViewBestSeller.dataSource = self
            self.setStartView()
            self.collectionViewOutlet.selectItem(at: .init(item: 0, section: 0), animated: true, scrollPosition: .left)
            self.splashImageOutlet.isHidden = true
            self.activitiOutlet.stopAnimating()
            self.activitiOutlet.isHidden = true
        }
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





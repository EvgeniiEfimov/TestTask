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
        collectionViewOutlet.dataSource = self
        
        collectionViewOutlet.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        collectionViewOutlet.selectItem(at: .init(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "selectCategory", for: indexPath) as! CollectionViewCell
        cell.imageViewCell.image = UIImage(named: "\(testArray[indexPath.item])")?.withRenderingMode(.alwaysTemplate)
        cell.labelCellOutlet.text = testArray[indexPath.item]
        cell.viewRound.layer.cornerRadius = cell.viewRound.frame.height / 2
        cell.viewRound.backgroundColor = UIColor.white
        if cell.isSelected == true {
            cell.isSelected = true
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
}

extension MainViewController: MainViewProtocol {
    func startConfig(_ data: Welcome?) {
        
    }
}


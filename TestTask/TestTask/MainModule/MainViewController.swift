//
//  ViewController.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var viewCell: UICollectionViewCell!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    let testArray = ["Phones", "Computer", "Health", "Books", "Tea", "Car"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        
        collectionViewOutlet.backgroundColor = UIColor.clear
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
        cell.labelCellOutlet.text = testArray[indexPath.item]
        cell.imageViewCell.image = UIImage.init(named: "Vector")
        cell.viewRound.layer.cornerRadius = cell.viewRound.frame.height / 2
        cell.viewRound.backgroundColor = UIColor.white
        return cell
    }
    
    
}


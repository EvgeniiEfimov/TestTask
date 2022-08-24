//
//  CollectionViewCell.swift
//  TestTask
//
//  Created by Евгений Ефимов on 20.08.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewCellOutlet: UIView!
    @IBOutlet weak var labelCellOutlet: UILabel!
    @IBOutlet weak var viewRound: UIView!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var stackViewSelect: UIStackView!
    
        override var isSelected: Bool {
            didSet {
                viewRound.backgroundColor = isSelected ? #colorLiteral(red: 1, green: 0.431372549, blue: 0.3058823529, alpha: 1) : UIColor.white
                imageViewCell.tintColor = isSelected ? #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1) : #colorLiteral(red: 0.7019590139, green: 0.7019622922, blue: 0.7705139518, alpha: 1)
                
            }
        }
}

class CollectionViewCellHotSales: UICollectionViewCell {
    @IBOutlet weak var imageViewHotSales: UIImageView!
    @IBOutlet weak var imageNewCellHotSales: UIImageView!
    @IBOutlet weak var labelModelCellHotSales: UILabel!
    @IBOutlet weak var labelInfoCellHotSales: UILabel!
    @IBOutlet weak var buttonBuyNowOutlet: UIButton!
    @IBOutlet weak var viewContentCell: UIView!
    
}

class CollectionViewCellBestSales: UICollectionViewCell {
    @IBOutlet weak var imageViewModelCellBS: UIImageView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelFullPrice: UILabel!
    @IBOutlet weak var labelModel: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    
    
}



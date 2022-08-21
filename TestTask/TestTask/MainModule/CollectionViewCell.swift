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
    
//    override var isHighlighted: Bool {
//           didSet {
//               if self.isHighlighted {
//                   viewRound.backgroundColor = UIColor.white
//               } else {
//                   viewRound.backgroundColor = UIColor.orange
//                   imageViewCell.image?.withTintColor(.white)
//               }
//           }
//       }
    

        override var isSelected: Bool {
            didSet {
                viewRound.backgroundColor = isSelected ? UIColor.orange : UIColor.white
                imageViewCell.tintColor = isSelected ? #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1) : #colorLiteral(red: 0.7019590139, green: 0.7019622922, blue: 0.7705139518, alpha: 1)
                
            }
        }
}

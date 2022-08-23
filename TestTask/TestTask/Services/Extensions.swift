//
//  ext.swift
//  TestTask
//
//  Created by Евгений Ефимов on 22.08.2022.
//

import UIKit

extension UITextField {
  func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 15, y: 15, width: 16, height: 16)) // set your Own size
    iconView.image = image
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
    iconContainerView.addSubview(iconView)
    leftView = iconContainerView
    leftViewMode = .always
    self.tintColor = .lightGray
  }
}

//@IBOutlet weak var paswd: UITextField! {
//    didSet{
//      paswd.setLeftView(image: UIImage.init(named: "password")!)
//      paswd.tintColor = .darkGray
//      paswd.isSecureTextEntry = true
//    }
// }

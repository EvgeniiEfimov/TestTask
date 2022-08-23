//
//  ext.swift
//  TestTask
//
//  Created by Евгений Ефимов on 22.08.2022.
//

import UIKit

extension UITextField {
  func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
    iconView.image = image
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
    iconContainerView.addSubview(iconView)
    leftView = iconContainerView
    leftViewMode = .always
    self.tintColor = .lightGray
  }
}

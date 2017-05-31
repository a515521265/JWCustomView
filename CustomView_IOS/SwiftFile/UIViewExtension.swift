//
//  UIViewExtension.swift
//  CustomView_IOS
//
//  Created by 梁家文 on 2017/5/31.
//
//

import Foundation
import UIKit


extension UIButton {
    class func creatButton(imageName:String, title:String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        return button
    }
}

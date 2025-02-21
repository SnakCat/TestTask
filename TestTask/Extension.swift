//
//  Extension.swift
//  TestTask
//
//  Created by Дмитрий Трушин on 21/02/2025.
//

import UIKit

//Расширение для добавления на view
extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach(addSubview)
    }
}

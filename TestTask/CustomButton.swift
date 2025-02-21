//
//  CustomButton.swift
//  TestTask
//
//  Created by Дмитрий Трушин on 21/02/2025.
//

import UIKit

//Кастомная кнопка для переиспользования
class CustomButton: UIButton {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabelCustom: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.blue.cgColor
        backgroundColor = .clear

        addSubview(iconImageView)
        addSubview(titleLabelCustom)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelCustom.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabelCustom.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabelCustom.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabelCustom.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    func configure(title: String, color: UIColor, icon: UIImage?) {
        titleLabelCustom.text = title
        titleLabelCustom.textColor = color
        layer.borderColor = color.cgColor
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = color
    }
}

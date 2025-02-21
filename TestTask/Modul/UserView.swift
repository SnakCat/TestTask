//
//  UserView.swift
//  TestTask
//
//  Created by Дмитрий Трушин on 21/02/2025.
//

import UIKit

final class UserView: UIViewController {
    
    //MARK: Свойства
    var presenter: UserPresenterProtocol!
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let nameField = CustomTextFieldView()
    private let ageField = CustomTextFieldView()
    private let childrenMaxLabel = UILabel()
    private let addChildrenButton = CustomButton()
    private let stackView = UIStackView()
    private let clearButton = CustomButton()
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setupConstraint()
        setupUI()
        reloadChildrenList()
    }
    //MARK: Вспомогательные методы
    //Добавление на view
    private func addSubView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleLabel, nameField, ageField, childrenMaxLabel, addChildrenButton, clearButton, stackView)
    }
    
    //Настройка констрейтов
    private func setupConstraint() {
        [scrollView, contentView, titleLabel, nameField, ageField, 
         childrenMaxLabel, addChildrenButton, stackView, clearButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            nameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            ageField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 8),
            ageField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ageField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            childrenMaxLabel.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 16),
            childrenMaxLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            addChildrenButton.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 10),
            addChildrenButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addChildrenButton.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: childrenMaxLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            clearButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            clearButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 40),
            clearButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            clearButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    //Настройка интерфейса
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "Персональные данные"
        titleLabel.font = .boldSystemFont(ofSize: 22)
        
        nameField.configure(title: "Имя", placeholder: "Введите ваше имя")
        
        ageField.configure(title: "Возраст", placeholder: "Введите ваш возраст")
        ageField.textField.keyboardType = .numberPad
        
        childrenMaxLabel.text = "Дети (макс. 5)"
        childrenMaxLabel.font = .boldSystemFont(ofSize: 22)
        
        addChildrenButton.configure(title: "Довабить ребенка", color: .systemBlue, icon: UIImage(systemName: "plus"))
        addChildrenButton.addTarget(self, action: #selector(addChildTapped), for: .touchUpInside)
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        clearButton.configure(title: "Очистить", color: .systemRed, icon: nil)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    }
    
    //MARK: Настройка стеков для добавления детей
    private func createChildView(for child: Child, at index: Int) -> UIView {
        let containerStack = UIStackView()
        containerStack.axis = .horizontal
        containerStack.spacing = 10
        containerStack.alignment = .top
        
        let leftStack = UIStackView()
        leftStack.axis = .vertical
        leftStack.spacing = 8
                
        let nameChild = CustomTextFieldView()
        nameChild.configure(title: "Имя", placeholder: "Введите имя ребенка")
        
        let ageChild = CustomTextFieldView()
        ageChild.configure(title: "Возраст", placeholder: "Введите возраст ребенка")
        ageChild.textField.keyboardType = .numberPad
        
        leftStack.addArrangedSubview(nameChild)
        leftStack.addArrangedSubview(ageChild)
        
        let removeButton = UIButton(type: .system)
        removeButton.setTitle("Удалить", for: .normal)
        removeButton.setTitleColor(.systemBlue, for: .normal)
        removeButton.addTarget(self, action: #selector(removeChildTapped), for: .touchUpInside)
        removeButton.tag = index
        
        containerStack.addArrangedSubview(leftStack)
        containerStack.addArrangedSubview(removeButton)
        
        leftStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        removeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return containerStack
    }
    
    //MARK: obj-c селекторы
    @objc private func addChildTapped() {
        presenter.addChild()
    }
    
    @objc private func removeChildTapped(_ sender: UIButton) {
        presenter.removeChild(at: sender.tag)
    }
    
    @objc private func clearTapped() {
        let actionSheet = UIAlertController(title: "Сбросить данные", message: "Вы действительно хотите очистить все данные?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive, handler: { _ in
            self.presenter.clearAllData()
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(actionSheet, animated: true)
    }
}

//MARK: Расширение для реализации протокола
extension UserView: UserViewProtocol {
    func reloadChildrenList() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (index, child) in presenter.children.enumerated() {
            let childView = createChildView(for: child, at: index)
            stackView.addArrangedSubview(childView)
        }
    }
    
    func toggleAddButton(isHidden: Bool) {
        addChildrenButton.isHidden = isHidden
    }
}

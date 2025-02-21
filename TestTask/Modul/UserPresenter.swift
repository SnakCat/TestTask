//
//  UserPresenter.swift
//  TestTask
//
//  Created by Дмитрий Трушин on 21/02/2025.
//

import Foundation

final class UserPresenter: UserPresenterProtocol {
    
    //MARK: Свойства
    weak var view: UserViewProtocol?
    var children: [Child] = []
    
    //MARK: Инициализатор
    init(view: UserViewProtocol) {
           self.view = view
       }
    
    //MARK: Методы
    //Добавить ребенка
    func addChild() {
        guard children.count < 5 else { return }
        children.append(Child(name: "", age: ""))
        view?.reloadChildrenList()
        view?.toggleAddButton(isHidden: children.count >= 5)
    }
    
    //Удалить ребенка
    func removeChild(at index: Int) {
        guard index < children.count else { return }
        children.remove(at: index)
        view?.reloadChildrenList()
        view?.toggleAddButton(isHidden: children.count >= 5)
    }
    
    //Очистить все
    func clearAllData() {
        children.removeAll()
        view?.reloadChildrenList()
        view?.toggleAddButton(isHidden: false)
    }
}

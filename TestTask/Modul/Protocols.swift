//
//  Protocols.swift
//  TestTask
//
//  Created by Дмитрий Трушин on 21/02/2025.
//

import Foundation

//Протокол для view
protocol UserViewProtocol: AnyObject {
    func reloadChildrenList()
    func toggleAddButton(isHidden: Bool)
}

//Протокол для presentor
protocol UserPresenterProtocol {
    var children: [Child] { get }
    func addChild()
    func removeChild(at index: Int)
    func clearAllData()
}

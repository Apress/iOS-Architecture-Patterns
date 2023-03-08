//
//  Coordinator.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 22/7/22.
//


import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}

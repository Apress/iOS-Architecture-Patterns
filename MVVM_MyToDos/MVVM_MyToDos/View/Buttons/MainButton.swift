//
//  MainButton.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class MainButton: UIButton {
    
    required init(title: String, color: UIColor) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = color
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 28, weight:  .light)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  FieldLabel.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class FieldLabel: UILabel {

    required init(title: String) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        font = .systemFont(ofSize: 21, weight: .light)
        textColor = .grayTextColor
        text = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

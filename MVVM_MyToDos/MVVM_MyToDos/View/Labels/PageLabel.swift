//
//  PageLabel.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class PageLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init(title: String) {
        super.init(frame: .zero)
        configure()
        setTitle(title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = .systemFont(ofSize: 40, weight: .light)
        textColor = .grayTextColor
    }
    
    func setTitle(_ title: String) {
        text = title
    }
}

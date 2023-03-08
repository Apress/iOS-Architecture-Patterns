//
//  TaskCheckButton.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class TaskCheckButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setButtonChecked(false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isChecked(_ checked: Bool) {
        setButtonChecked(checked)
    }
    
    func setButtonChecked(_ checked: Bool) {
        let icon = UIImage(systemName: checked ? "checkmark.circle.fill" : "circle")?
            .withTintColor(.mainCoralColor, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 20.0))
        setImage(icon, for: .normal)
    }
}

//
//  IconCell.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class IconCell: UICollectionViewCell {
    
    static let reuseId = "IconCell"
    
    private var image = UIImageView(frame: .zero)
    private var iconColor: UIColor!
    private var title: String!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .center
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        image.image = nil
        title = ""
    }
    
    override var isSelected: Bool {
        didSet {
            setImageWithName(title, isSelected: isSelected)
        }
    }
    
    func setImageWithName(_ name: String, iconColor: UIColor) {
        
        self.title = name
        self.iconColor = iconColor
        
        setImageWithName(name, isSelected: false)
    }
}


private extension IconCell {
    
    func setImageWithName(_ name: String, isSelected: Bool) {
        let icon = UIImage(systemName: name)?
            .withTintColor(isSelected ? .darkGray : iconColor, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 30.0))
        
        image.image = icon
    }
}

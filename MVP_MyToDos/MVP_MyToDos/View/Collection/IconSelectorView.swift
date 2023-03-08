//
//  IconSelectorView.swift
//  MVP_MyToDos
//
//  Created by Raúl Ferrer on 10/5/22.
//

import UIKit

protocol IconSelectorViewDelegate: AnyObject {
    func selectedIcon(_ icon: String)
}

class IconSelectorView: UIView {
   
    private var collectionView: UICollectionView!
    private var iconColor: UIColor!
    
    weak var delegate: IconSelectorViewDelegate?

    required init(frame: CGRect, iconColor: UIColor) {
        super.init(frame: frame)
        self.iconColor = iconColor
        backgroundColor = .white
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension IconSelectorView {
    
    func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 50, height: 50)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: "IconCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension IconSelectorView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.icons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath as IndexPath) as! IconCell
        cell.setImageWithName(Constants.icons[indexPath.item], iconColor: iconColor)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedIcon(Constants.icons[indexPath.item])
    }
}

//
//  AddListViewController.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class AddListViewController: UIViewController, PresenterToViewAddListProtocol {

    private(set) var backButton = BackButton(frame: .zero)
    private(set) var pageTitle = PageLabel(title: "Add List")
    private(set) var titleLabel = FieldLabel(title: "Title")
    private(set) var titleTextfield = UITextField()
    private(set) var iconLabel = FieldLabel(title: "Icon")
    private(set) var iconSelectorView = IconSelectorView(frame: .zero, iconColor: .mainBlueColor)
    private(set) var addListButton = MainButton(title: "Add List", color: .mainBlueColor)
    private(set) var listModel = TasksListModel()
    
    var presenter: ViewToPresenterAddListProtocol!

    
    override func loadView() {
        super.loadView()
        setupAddListView()
    }
    
    private func setupAddListView() {
        view.backgroundColor = .white
        configureBackButton()
        configurePageTitleLabel()
        configureTitleLabel()
        configureTitleTextfield()
        configureIconLabel()
        configureAddListButton()
        configureCollectionView()
    }
}

extension AddListViewController {
    
    func configureBackButton() {
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func backAction() {
        presenter.backAction()
    }
    
    func configurePageTitleLabel() {
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configureTitleTextfield() {
        titleTextfield.translatesAutoresizingMaskIntoConstraints = false
        titleTextfield.placeholder = "Add list title"
        titleTextfield.textColor = .grayTextColor
        titleTextfield.attributedPlaceholder = NSAttributedString(
            string: "Add list title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayBackgroundColor]
        )
        view.addSubview(titleTextfield)
        
        NSLayoutConstraint.activate([
            titleTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextfield.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureIconLabel() {
        view.addSubview(iconLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            iconLabel.topAnchor.constraint(equalTo: titleTextfield.bottomAnchor, constant: 20),
            iconLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configureAddListButton() {
        addListButton.addTarget(self, action: #selector(addListAction), for: .touchUpInside)
        view.addSubview(addListButton)
        
        NSLayoutConstraint.activate([
            addListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            addListButton.widthAnchor.constraint(equalToConstant: 150),
            addListButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func addListAction() {
        guard titleTextfield.hasText else { return }
        listModel.title = titleTextfield.text
        listModel.id = ProcessInfo().globallyUniqueString
        listModel.icon = listModel.icon ?? "checkmark.seal.fill"
        listModel.createdAt = Date()
        presenter.addList(taskList: listModel)
    }
    
    func configureCollectionView() {
        iconSelectorView.translatesAutoresizingMaskIntoConstraints = false
        iconSelectorView.delegate = self
        view.addSubview(iconSelectorView)
        
        NSLayoutConstraint.activate([
            iconSelectorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconSelectorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            iconSelectorView.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 10),
            iconSelectorView.bottomAnchor.constraint(equalTo: addListButton.topAnchor, constant: -20)
        ])
    }
}

extension AddListViewController: IconSelectorViewDelegate {
    
    func selectedIcon(_ icon: String) {
        listModel.icon = icon
    }
}

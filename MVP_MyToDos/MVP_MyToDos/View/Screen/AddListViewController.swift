//
//  AddListViewController.swift
//  MVP_MyToDos
//
//  Created by Raúl Ferrer on 10/5/22.
//

import UIKit

class AddListViewController: UIViewController {

    private var addListView = AddListView()
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupAddListView()
    }
    
    private func setupAddListView() {
        let presenter = AddListPresenter(addListView: addListView, tasksListService: TasksListService())
        addListView.delegate = self
        addListView.presenter = presenter
        self.view = addListView
    }
    
    
    private func backToHome() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddListViewController: BackButtonDelegate {
    
    func navigateBack() {
        backToHome()
    }
}

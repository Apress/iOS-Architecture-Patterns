//
//  AddListViewController.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class AddListViewController: UIViewController {

    private var addListView: AddListView!
        
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
        let viewModel = AddListViewModel(tasksListService: TasksListService())
        addListView = AddListView(viewModel: viewModel)
        addListView.delegate = self
        self.view = addListView
    }
}

extension AddListViewController: BackButtonDelegate {
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}

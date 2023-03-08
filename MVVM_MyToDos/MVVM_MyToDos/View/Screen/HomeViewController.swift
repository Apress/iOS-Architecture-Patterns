//
//  HomeViewController.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var homeView: HomeView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupHomeView()
    }

    private func setupHomeView() {
        let viewModel = HomeViewModel(tasksListService: TasksListService())
        homeView = HomeView(viewModel: viewModel)
        homeView.delegate = self
        self.view = homeView
    }
}


extension HomeViewController: HomeViewControllerDelegate {
    
    func addList() {
        navigationController?.pushViewController(AddListViewController(), animated: true)
    }
    
    func selectedList(_ list: TasksListModel) {
        let taskViewController = TaskListViewController(tasksListModel: list)
        navigationController?.pushViewController(taskViewController, animated: true)
    }
}

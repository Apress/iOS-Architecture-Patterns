//
//  HomeViewController.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var homeView: HomeView!
    private var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupHomeView()
    }

    private func setupHomeView() {
        homeView = HomeView(viewModel: viewModel)
        self.view = homeView
    }
}

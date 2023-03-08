//
//  AddTaskViewController.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    private var addTaskView: AddTaskView!
    private var viewModel: AddTaskViewModel!

    init(viewModel: AddTaskViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupAddTaskView()
    }
    
    private func setupAddTaskView() {
        addTaskView = AddTaskView(viewModel: viewModel)
        self.view = addTaskView
    }
}

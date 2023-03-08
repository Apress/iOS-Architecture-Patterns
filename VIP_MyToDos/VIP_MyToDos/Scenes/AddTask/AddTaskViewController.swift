//
//  AddTaskViewController.swift
//  VIP_MyToDos
//

import UIKit

protocol AddTaskDelegate: AnyObject {
    func didAddTask()
}

protocol AddTaskViewControllerInput: AnyObject {
    func dismissView()
}

protocol AddTaskViewControllerOutput: AnyObject {
    func addTask(request: AddTaskModel.AddTask.Request)
}

final class AddTaskViewController: UIViewController {
    var interactor: AddTaskInteractorInput?
    var router: AddTaskRouterDelegate?
    
    private let addTaskView: AddTaskView
    
    init(addTaskView: AddTaskView) {
        self.addTaskView = addTaskView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskView.delegate = self
        self.view = addTaskView
    }
}

extension AddTaskViewController: AddTaskViewControllerInput {
    
    func dismissView() {
        router?.dismissView()
    }
}

extension AddTaskViewController: AddTaskViewDelegate {
    
    func addTaskWith(title: String, icon: String) {
        let request = AddTaskModel.AddTask.Request(title: title, icon: icon)
        interactor?.addTask(request: request)
    }    
}

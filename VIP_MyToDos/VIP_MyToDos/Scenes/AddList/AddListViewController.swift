//
//  AddListViewController.swift
//  VIP_MyToDos
//

import UIKit

protocol AddListDelegate: AnyObject {
    func didAddList()
}

protocol AddListViewControllerInput: AnyObject {
    func navigateToHome()
}

protocol AddListViewControllerOutput: AnyObject {
    func navigateBack()
    func addList(request: AddListModel.AddList.Request)
}

final class AddListViewController: UIViewController {
    var interactor: AddListInteractorInput?
    var router: AddListRouterDelegate?
    
    private let addListView: AddListView
    
    init(addListView: AddListView) {
        self.addListView = addListView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addListView.delegate = self
        self.view = addListView
    }
}

extension AddListViewController: AddListViewControllerInput {
    
    func navigateToHome() {
        router?.navigateBack()
    }
}

extension AddListViewController: AddListViewDelegate {
    
    func navigateBack() {
        interactor?.navigateBack()
    }
    
    func addListWith(title: String, icon: String) {
        let request = AddListModel.AddList.Request(title: title, icon: icon)
        interactor?.addList(request: request)
    }
}

//
//  AddListInteractor.swift
//  VIP_MyToDos
//

import Foundation

protocol AddListInteractorOutput: AnyObject {
    func navigateBack()
}

typealias AddListInteractorInput = AddListViewControllerOutput

final class AddListInteractor {
    var presenter: AddListPresenterInput?
    
    private let tasksListService: TasksListServiceProtocol!

    weak var delegate: AddListDelegate?

    init(tasksListService: TasksListServiceProtocol, delegate: AddListDelegate) {
        self.tasksListService = tasksListService
        self.delegate = delegate
    }
}

extension AddListInteractor: AddListInteractorInput {
    
    func navigateBack() {
        presenter?.navigateBack()
    }
    
    func addList(request: AddListModel.AddList.Request) {
        let list = TasksListModel(id: ProcessInfo().globallyUniqueString,
                                  title: request.title,
                                  icon: request.icon,
                                  createdAt: Date())
        tasksListService.saveTasksList(list)
        delegate?.didAddList()
        presenter?.navigateBack()
    }
}

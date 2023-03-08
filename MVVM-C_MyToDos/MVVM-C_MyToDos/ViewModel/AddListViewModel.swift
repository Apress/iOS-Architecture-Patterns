//
//  AddListViewModel.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import RxRelay
import RxCocoa

class AddListViewModel {
    
    var input: Input!
    var coordinator: AddListCoordinatorProtocol!
    
    struct Input {
        let icon: PublishRelay<String>
        let title: PublishRelay<String>
        let addList: PublishRelay<Void>
        let dismiss: PublishRelay<Void>
    }

    private var tasksListService: TasksListServiceProtocol!
    private(set) var list: TasksListModel!
    
    init(tasksListService: TasksListServiceProtocol, coordinator: AddListCoordinatorProtocol) {
        self.tasksListService = tasksListService
        self.coordinator = coordinator
        self.list = TasksListModel(id: ProcessInfo().globallyUniqueString,
                                   icon: "checkmark.seal.fill",
                                   createdAt: Date())
        // Inputs
        let icon = PublishRelay<String>()
        _ = icon.subscribe(onNext: { [self] newIcon in
            list.icon = newIcon
        })
        let title = PublishRelay<String>()
        _ = title.subscribe(onNext: { [self] newTitle in
            list.title = newTitle
        })
        let addList = PublishRelay<Void>()
        _ = addList.subscribe(onNext: { [self] _ in
            tasksListService.saveTasksList(list)
            coordinator.navigateBack()
        })
        let dismissView = PublishRelay<Void>()
        _ = dismissView.subscribe(onNext: { _ in
            coordinator.navigateBack()
        })
        input = Input(icon: icon, title: title, addList: addList, dismiss: dismissView)
    }
}

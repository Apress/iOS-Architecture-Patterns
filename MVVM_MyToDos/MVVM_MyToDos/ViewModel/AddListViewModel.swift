//
//  AddListViewModel.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import RxRelay
import RxCocoa

class AddListViewModel {
    
    var output: Output!
    var input: Input!
    
    struct Input {
        let icon: PublishRelay<String>
        let title: PublishRelay<String>
        let addList: PublishRelay<Void>
        let dismiss: PublishRelay<Void>
    }
    
    struct Output {
        let dismiss: Driver<Void>
    }

    private var tasksListService: TasksListServiceProtocol!
    private(set) var list: TasksListModel!
    
    private let dismiss = BehaviorRelay<Void>(value: ())

    init(tasksListService: TasksListServiceProtocol) {
        self.tasksListService = tasksListService
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
            dismiss.accept(())
        })
        let dismissView = PublishRelay<Void>()
        _ = dismissView.subscribe(onNext: { [self] _ in
            dismiss.accept(())
        })
        input = Input(icon: icon, title: title, addList: addList, dismiss: dismissView)
        
        // Outputs
        let backNavigation = dismiss.asDriver()
        output = Output(dismiss: backNavigation)
    }
}

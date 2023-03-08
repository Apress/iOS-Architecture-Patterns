//
//  MockTaskListService.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 1/6/22.
//

@testable import MVP_MyToDos

class MockTaskListService: TasksListServiceProtocol {
    
    required init(coreDataManager: CoreDataManager) {}
    
    private var lists: [TasksListModel] = [TasksListModel]()

    convenience init(lists: [TasksListModel]) {
        self.init(coreDataManager: CoreDataManager.shared)
        self.lists = lists
    }
    
    func saveTasksList(_ list: TasksListModel) {
        lists.append(list)
    }
    
    func fetchLists() -> [TasksListModel] {
        return lists
    }

    func fetchListWithId(_ id: String) -> TasksListModel? {
        return lists.filter({ $0.id == id }).first
    }
    
    func deleteList(_ list: TasksListModel) {
        lists = lists.filter({ $0.id != list.id })
    }
}

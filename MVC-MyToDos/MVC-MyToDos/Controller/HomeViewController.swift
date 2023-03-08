//
//  HomeViewController.swift
//  MVC-MyToDos
//
//  Created by Raúl Ferrer on 2/4/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    private var homeView = HomeView()
    private var tasksListService: TasksListServiceProtocol!
    private var taskService: TaskServiceProtocol!

    init(tasksListService: TasksListServiceProtocol,
         taskService: TaskServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.tasksListService = tasksListService
        self.taskService = taskService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupHomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }

    private func setupHomeView() {
        homeView.delegate = self
        fetchTasksLists()
        self.view = homeView
    }
}

extension HomeViewController {
    
    func fetchTasksLists() {
        let lists = tasksListService.fetchLists()
        homeView.setTasksLists(lists)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasksLists()
    }
}


extension HomeViewController: HomeViewDelegate {
    
    func addListAction() {
        let addListViewController = AddListViewController(tasksListService: tasksListService)
        navigationController?.pushViewController(addListViewController, animated: true)
    }
    
    func selectedList(_ list: TasksListModel) {
        let taskViewController = TaskListViewController(tasksListModel: list, taskService: taskService, tasksListService: tasksListService)
        navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    func deleteList(_ list: TasksListModel) {
        tasksListService.deleteList(list)
    }
}

//
//  TaskListViewController.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class TaskListViewController: UIViewController {
    
    private(set) var backButton = BackButton(frame: .zero)
    private(set) var pageTitle = PageLabel(frame: .zero)
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var addTaskButton = MainButton(title: "Add Task", color: .mainCoralColor)
    private(set) var emptyState = EmptyStateView(frame: .zero, title: "Press 'Add Task' to add your first task to the list")

    var presenter: ViewToPresenterTaskListProtocol!
    
    override func loadView() {
        super.loadView()
        setupTaskListView()
        presenter.viewDidLoad()
    }
    
    private func setupTaskListView() {
        view.backgroundColor = .white
        configureBackButton()
        configurePageTitleLabel()
        configureAddTaskButton()
        configureTableView()
        configureEmptyState()
    }
}

private extension TaskListViewController {
    
    func configureBackButton() {
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func backAction() {
        presenter.backAction()
    }
    
    func configurePageTitleLabel() {
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureAddTaskButton() {
        addTaskButton.addTarget(self, action: #selector(addTaskAction), for: .touchUpInside)
        view.addSubview(addTaskButton)
        
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            addTaskButton.widthAnchor.constraint(equalToConstant: 200),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func addTaskAction() {
        presenter?.addTask()
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseId)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -40)
        ])
    }
    
    func configureEmptyState() {
        view.addSubview(emptyState)
        
        NSLayoutConstraint.activate([
            emptyState.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
            emptyState.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20),
            emptyState.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            emptyState.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -40)
        ])
    }
}


extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseId, for: indexPath) as! TaskCell
        cell.setParametersForTask(presenter.taskAt(indexPath: indexPath))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteRowAt(indexPath: indexPath)
        }
    }
}

extension TaskListViewController: TaskCellDelegate {
    
    func updateTask(_ task: TaskModel) {
        presenter.update(task: task)
    }
}

extension TaskListViewController: PresenterToViewTaskListProtocol {
    
    func onFetchTasks() {
        tableView.reloadData()
    }
    
    func showEmptyState() {
        emptyState.isHidden = false
    }
    
    func hideEmptyState() {
        emptyState.isHidden = true
    }
}

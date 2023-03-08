//
//  TaskListView.swift
//  MVP_MyToDos
//
//  Created by Raúl Ferrer on 10/5/22.
//

import UIKit

protocol TaskListViewControllerDelegate: AnyObject {
    func addTask()
}

protocol TaskListViewDelegate: AnyObject {
    func setPageTitle(_ title: String)
    func reloadData()
}

class TaskListView: UIView {
    
    private(set) var backButton = BackButton(frame: .zero)
    private(set) var pageTitle = PageLabel(frame: .zero)
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var addTaskButton = MainButton(title: "Add Task", color: .mainCoralColor)
    private(set) var emptyState = EmptyStateView(frame: .zero, title: "Press 'Add Task' to add your first task to the list")
    private var tasks = [TaskModel]()
    
    var presenter: TasksListPresenter!
    
    weak var delegate: (TaskListViewControllerDelegate & BackButtonDelegate)?


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        configureBackButton()
        configurePageTitleLabel()
        configureAddTaskButton()
        configureTableView()
        configureEmptyState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        presenter.setupView()
    }
}

private extension TaskListView {
    
    func configureBackButton() {
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func backAction() {
        delegate?.navigateBack()
    }
    
    func configurePageTitleLabel() {
        addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            pageTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureAddTaskButton() {
        addTaskButton.addTarget(self, action: #selector(addTaskAction), for: .touchUpInside)
        addSubview(addTaskButton)
        
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            addTaskButton.widthAnchor.constraint(equalToConstant: 200),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func addTaskAction() {
        delegate?.addTask()
    }

    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseId)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -40)
        ])
    }
    
    func configureEmptyState() {
        addSubview(emptyState)
        
        NSLayoutConstraint.activate([
            emptyState.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
            emptyState.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20),
            emptyState.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            emptyState.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -40)
        ])
    }
}


extension TaskListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseId, for: indexPath) as! TaskCell
        cell.setParametersForTask(presenter.taskAtIndex(indexPath.row))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeTaskAtIndex(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TaskListView: TaskCellDelegate {
    
    func updateTask(_ task: TaskModel) {
        presenter.updateTask(task)
    }
}

extension TaskListView: TaskListViewDelegate {
    
    func setPageTitle(_ title: String) {
        pageTitle.text = title
    }
    
    
    func reloadData() {
        tableView.reloadData()
        emptyState.isHidden = presenter.numberOfTasks > 0
    }
}

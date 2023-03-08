//
//  HomeView.swift
//  MVP_MyToDos
//
//  Created by Raúl Ferrer on 10/5/22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func addList()
    func selectedList(_ list: TasksListModel)
}

protocol HomeViewDelegate: AnyObject {
    func reloadData()
}

class HomeView: UIView {
    
    private(set) var pageTitle = PageLabel(title: "My To Do Lists")
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var addListButton = MainButton(title: "Add List", color: .mainBlueColor)
    private(set) var emptyState = EmptyStateView(frame: .zero, title: "Press 'Add List' to start")
    
    var presenter: HomePresenter!
    
    weak var delegate: HomeViewControllerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configurePageTitleLabel()
        configureAddListButton()
        configureTableView()
        configureEmptyState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        presenter.fetchTasksLists()
    }
}

private extension HomeView {
    
    func configurePageTitleLabel() {
        addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureAddListButton() {
        addListButton.addTarget(self, action: #selector(addListAction), for: .touchUpInside)
        addSubview(addListButton)
        
        NSLayoutConstraint.activate([
            addListButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addListButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            addListButton.widthAnchor.constraint(equalToConstant: 200),
            addListButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func addListAction() {
        delegate?.addList()
    }

    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: ToDoListCell.reuseId)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: addListButton.topAnchor, constant: -40)
        ])
    }
    
    
    func configureEmptyState() {
        addSubview(emptyState)
        
        NSLayoutConstraint.activate([
            emptyState.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
            emptyState.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20),
            emptyState.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            emptyState.bottomAnchor.constraint(equalTo: addListButton.topAnchor, constant: -40)
        ])
    }
}


extension HomeView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedList(presenter.listAtIndex(indexPath.row))
    }
}


extension HomeView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTaskLists
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListCell.reuseId, for: indexPath) as! ToDoListCell
        cell.setCellParametersForList(presenter.listAtIndex(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeListAtIndex(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


extension HomeView: HomeViewDelegate {
    
    func reloadData() {
        tableView.reloadData()
        emptyState.isHidden = presenter.numberOfTaskLists > 0
    }
}

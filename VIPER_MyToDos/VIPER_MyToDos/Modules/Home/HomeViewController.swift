//
//  HomeViewController.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private(set) var pageTitle = PageLabel(title: "My To Do Lists")
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var addListButton = MainButton(title: "Add List", color: .mainBlueColor)
    private(set) var emptyState = EmptyStateView(frame: .zero, title: "Press 'Add List' to start")
        
    var presenter: ViewToPresenterHomeProtocol!
    
    override func loadView() {
        super.loadView()
        setupHomeView()
        presenter.viewDidLoad()
    }

    private func setupHomeView() {
        view.backgroundColor = .white
        configurePageTitleLabel()
        configureAddListButton()
        configureTableView()
        configureEmptyState()
    }
}

private extension HomeViewController {
    
    func configurePageTitleLabel() {
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureAddListButton() {
        addListButton.addTarget(self, action: #selector(addListAction), for: .touchUpInside)
        view.addSubview(addListButton)
        
        NSLayoutConstraint.activate([
            addListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            addListButton.widthAnchor.constraint(equalToConstant: 200),
            addListButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func addListAction() {
        presenter.addTaskList()
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.separatorColor = .clear
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: ToDoListCell.reuseId)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: addListButton.topAnchor, constant: -40)
        ])
    }
    
    func configureEmptyState() {
        view.addSubview(emptyState)
        
        NSLayoutConstraint.activate([
            emptyState.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
            emptyState.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20),
            emptyState.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            emptyState.bottomAnchor.constraint(equalTo: addListButton.topAnchor, constant: -40)
        ])
    }
}


extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectRowAt(indexPath: indexPath)
    }
}


extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListCell.reuseId, for: indexPath) as! ToDoListCell
        cell.setCellParametersForList(presenter.listAt(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteRowAt(indexPath: indexPath)
        }
    }
}

extension HomeViewController: PresenterToViewHomeProtocol {
    
    func onFetchLists() {
        tableView.reloadData()
    }
    
    func showEmptyState() {
        emptyState.isHidden = false
    }
    
    func hideEmptyState() {
        emptyState.isHidden = true
    }
}

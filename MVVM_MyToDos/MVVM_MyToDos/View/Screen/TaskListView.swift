//
//  TaskListView.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit
import RxSwift

protocol TaskListViewControllerDelegate: AnyObject {
    func addTask()
}

class TaskListView: UIView {
    
    private(set) var backButton = BackButton(frame: .zero)
    private(set) var pageTitle = PageLabel(frame: .zero)
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var addTaskButton = MainButton(title: "Add Task", color: .mainCoralColor)
    private(set) var emptyState = EmptyStateView(frame: .zero, title: "Press 'Add Task' to add your first task to the list")
    private var tasks = [TaskModel]()
    
    private let viewModel: TaskListViewModel!
    private let disposeBag = DisposeBag()
    
    weak var delegate: (TaskListViewControllerDelegate & BackButtonDelegate)?

    init(frame: CGRect = .zero, viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        configureBackButton()
        configurePageTitleLabel()
        configureAddTaskButton()
        configureTableView()
        configureEmptyState()
        bindViewToModel(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TaskListView {
    
    func configureBackButton() {
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
        ])
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
        addSubview(addTaskButton)
        
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            addTaskButton.widthAnchor.constraint(equalToConstant: 200),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.bounces = false
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
    
    func bindViewToModel(_ viewModel: TaskListViewModel) {
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .bind(to: viewModel.input.deleteRow)
            .disposed(by: disposeBag)
        
        viewModel.output.tasks
            .drive(tableView.rx.items(cellIdentifier: TaskCell.reuseId, cellType: TaskCell.self)) { (index, task, cell) in
                cell.setParametersForTask(task, at: index)
                cell.checkButton.rx.tap
                    .map({ IndexPath(row: cell.cellIndex, section: 0) })
                    .bind(to: viewModel.input.updateRow)
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        addTaskButton.rx.tap
            .asDriver()
            .drive(onNext: { [self] in
                delegate?.addTask()
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [self] in
                delegate?.navigateBack()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.pageTitle
            .drive(pageTitle.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.hideEmptyState
            .drive(emptyState.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.input.reload.accept(())
    }
}


extension TaskListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

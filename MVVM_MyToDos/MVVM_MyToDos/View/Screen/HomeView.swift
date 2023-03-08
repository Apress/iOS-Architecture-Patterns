//
//  HomeView.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit
import RxSwift

protocol HomeViewControllerDelegate: AnyObject {
    func addList()
    func selectedList(_ list: TasksListModel)
}

class HomeView: UIView {
    
    private(set) var pageTitle = PageLabel(title: "My To Do Lists")
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var addListButton = MainButton(title: "Add List", color: .mainBlueColor)
    private(set) var emptyState = EmptyStateView(frame: .zero, title: "Press 'Add List' to start")
    
    private let viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()

    weak var delegate: HomeViewControllerDelegate?
    
    init(frame: CGRect = .zero, viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        configurePageTitleLabel()
        configureAddListButton()
        configureTableView()
        configureEmptyState()
        bindViewToModel(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        addSubview(addListButton)
        
        NSLayoutConstraint.activate([
            addListButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addListButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            addListButton.widthAnchor.constraint(equalToConstant: 200),
            addListButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.bounces = false
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
    
    func bindViewToModel(_ viewModel: HomeViewModel) {
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .bind(to: viewModel.input.deleteRow)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: viewModel.input.selectRow)
            .disposed(by: disposeBag)
        
        viewModel.output.lists
            .drive(tableView.rx.items(cellIdentifier: ToDoListCell.reuseId, cellType: ToDoListCell.self)) { (_, list, cell) in
                cell.setCellParametersForList(list)
            }
            .disposed(by: disposeBag)
        
        addListButton.rx.tap
            .asDriver()
            .drive(onNext: { [self] in
                delegate?.addList()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.hideEmptyState
            .drive(emptyState.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.output.selectedList
            .drive(onNext: { [self] list in
                delegate?.selectedList(list)
            })
            .disposed(by: disposeBag)
        
        viewModel.input.reload.accept(())
    }
}


extension HomeView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//
//  AddTaskViewController.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit

class AddTaskViewController: UIViewController, PresenterToViewAddTaskProtocol {

    private(set) var backButton = BackButton()
    private(set) var pageTitle = PageLabel(title: "Add Task")
    private(set) var titleLabel = UILabel(frame: .zero)
    private(set) var titleTextfield = UITextField()
    private(set) var iconLabel = UILabel(frame: .zero)
    private(set) var iconSelectorView = IconSelectorView(frame: .zero, iconColor: .mainCoralColor)
    private(set) var addTaskButton = MainButton(title: "Add Task", color: .mainCoralColor)
    private(set) var taskModel = TaskModel()

    var presenter: ViewToPresenterAddTaskProtocol!

    override func loadView() {
        super.loadView()
        setupAddTaskView()
    }
    
    private func setupAddTaskView() {
        view.backgroundColor = .white
        configurePageTitleLabel()
        configureTitleLabel()
        configureTitleTextfield()
        configureIconLabel()
        configureAddTaskButton()
        configureCollectionView()
    }
}

extension AddTaskViewController {
    
    func configurePageTitleLabel() {
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 21, weight: .light)
        titleLabel.textColor = .grayTextColor
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configureTitleTextfield() {
        titleTextfield.translatesAutoresizingMaskIntoConstraints = false
        titleTextfield.textColor = .grayTextColor
        titleTextfield.attributedPlaceholder = NSAttributedString(
            string: "Add task",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayBackgroundColor]
        )
        view.addSubview(titleTextfield)
        
        NSLayoutConstraint.activate([
            titleTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextfield.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureIconLabel() {
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.text = "Icon"
        iconLabel.font = .systemFont(ofSize: 21, weight: .light)
        iconLabel.textColor = .grayTextColor
        view.addSubview(iconLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            iconLabel.topAnchor.constraint(equalTo: titleTextfield.bottomAnchor, constant: 20),
            iconLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configureAddTaskButton() {
        addTaskButton.addTarget(self, action: #selector(addTaskAction), for: .touchUpInside)
        view.addSubview(addTaskButton)
        
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            addTaskButton.widthAnchor.constraint(equalToConstant: 150),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func addTaskAction() {
        guard titleTextfield.hasText else { return }
        
        taskModel.title = titleTextfield.text
        taskModel.icon = taskModel.icon ?? "checkmark.seal.fill"
        taskModel.done = false
        taskModel.id = ProcessInfo().globallyUniqueString
        taskModel.createdAt = Date()
        presenter.addTask(task: taskModel)
    }
    
    func configureCollectionView() {
        iconSelectorView.translatesAutoresizingMaskIntoConstraints = false
        iconSelectorView.delegate = self
        view.addSubview(iconSelectorView)
        
        NSLayoutConstraint.activate([
            iconSelectorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconSelectorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            iconSelectorView.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 10),
            iconSelectorView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -20)
        ])
    }
}

extension AddTaskViewController: IconSelectorViewDelegate {
    
    func selectedIcon(_ icon: String) {
        taskModel.icon = icon
    }
}

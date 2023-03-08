//
//  AddTaskView.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import UIKit
import RxSwift

protocol AddedTaskViewControllerDelegate: AnyObject {
    func addedTask()
}

class AddTaskView: UIView {
    
    private(set) var backButton = BackButton()
    private(set) var pageTitle = PageLabel(title: "Add Task")
    private(set) var titleLabel = UILabel(frame: .zero)
    private(set) var titleTextfield = UITextField()
    private(set) var iconLabel = UILabel(frame: .zero)
    private(set) var iconSelectorView = IconSelectorView(frame: .zero, iconColor: .mainCoralColor)
    private(set) var addTaskButton = MainButton(title: "Add Task", color: .mainCoralColor)
    
    private let viewModel: AddTaskViewModel!
    private let disposeBag = DisposeBag()
        
    weak var delegate: AddedTaskViewControllerDelegate?

    init(frame: CGRect = .zero, viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        configurePageTitleLabel()
        configureTitleLabel()
        configureTitleTextfield()
        configureIconLabel()
        configureAddTaskButton()
        configureCollectionView()
        bindViewToModel(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddTaskView {

    func configurePageTitleLabel() {
        addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 21, weight: .light)
        titleLabel.textColor = .grayTextColor
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
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
        addSubview(titleTextfield)
        
        NSLayoutConstraint.activate([
            titleTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleTextfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextfield.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureIconLabel() {
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.text = "Icon"
        iconLabel.font = .systemFont(ofSize: 21, weight: .light)
        iconLabel.textColor = .grayTextColor
        addSubview(iconLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            iconLabel.topAnchor.constraint(equalTo: titleTextfield.bottomAnchor, constant: 20),
            iconLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configureAddTaskButton() {
        addSubview(addTaskButton)
        
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            addTaskButton.widthAnchor.constraint(equalToConstant: 150),
            addTaskButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureCollectionView() {
        iconSelectorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconSelectorView)
        
        NSLayoutConstraint.activate([
            iconSelectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconSelectorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            iconSelectorView.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 10),
            iconSelectorView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -20)
        ])
    }
    
    func bindViewToModel(_ viewModel: AddTaskViewModel) {
        
        titleTextfield
            .rx.text
            .map({!($0?.isEmpty)!})
            .bind(to: addTaskButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        titleTextfield.rx.text
            .map({ $0! })
            .bind(to: viewModel.input.title )
            .disposed(by: disposeBag)
        
        addTaskButton.rx.tap
            .bind(to: viewModel.input.addTask)
            .disposed(by: disposeBag)
        
        iconSelectorView.selectedIcon
            .bind(to: viewModel.input.icon)
            .disposed(by: disposeBag)
    
        viewModel.output.dismiss
            .skip(1)
            .drive(onNext: { [self] in
                delegate?.addedTask()
            })
            .disposed(by: disposeBag)
    }
}

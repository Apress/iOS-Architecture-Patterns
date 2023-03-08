//
//  AddListViewTest.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 1/6/22.
//

import XCTest

@testable import MVP_MyToDos

class AddListViewTest: XCTestCase {
    
    var sut: AddListView!
    var presenter: AddListPresenter!


    override func setUpWithError() throws {
        sut = AddListView()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testViewLoaded_whenViewIsInstantiated_shouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.titleTextfield)
        XCTAssertNotNil(sut.iconLabel)
        XCTAssertNotNil(sut.iconSelectorView)
        XCTAssertNotNil(sut.addListButton)
    }
    
    func testButtonAction_whenAddListButtonIsTapped_shouldBeCalledAddListAction() {
        let addListButton = sut.addListButton
        XCTAssertNotNil(addListButton, "UIButton does not exists")
        
        guard let addListButtonAction = addListButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Not actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(addListButtonAction.contains("addListAction"))
    }

    func testButtonAction_whenBackButtonIsTapped_shouldBeCalledBackAction() {
        let backButton = sut.backButton
        XCTAssertNotNil(backButton, "UIButton does not exists")
        
        guard let backButtonAction = backButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Not actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(backButtonAction.contains("backAction"))
    }
    
    func testTextField_whenTextfieldIsCreated_shouldBeEmpty() {
        XCTAssertEqual(sut.titleTextfield.text, "")
    }
    
    func testTextField_whenTextfiledhasText_shouldBeCreatedList() {
        let mockTaskListService = MockTaskListService(lists: [TasksListModel]())
        presenter = AddListPresenter(addListView: sut,
                                     tasksListService: mockTaskListService)
        sut.presenter = presenter
        sut.titleTextfield.text = "Test title"
        sut.addListAction()
        XCTAssertEqual(presenter.list.title, "Test title")
    }
    
    func testIcon_whenIconIsSetted_shouldBeIconInList() {
        let mockTaskListService = MockTaskListService(lists: [TasksListModel]())
        presenter = AddListPresenter(addListView: sut,
                                     tasksListService: mockTaskListService)
        sut.presenter = presenter
        sut.selectedIcon("test.icon")
        XCTAssertEqual(presenter.list.icon, "test.icon")
    }
}

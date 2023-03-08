//
//  AddListViewTests.swift
//  MVVM_MyToDosTests
//
//  Created by Raúl Ferrer on 16/7/22.
//

import XCTest

@testable import MVVM_MyToDos

class AddListViewTests: XCTestCase {

    var sut: AddListView!
    
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    
    override func setUpWithError() throws {
        let viewModel = AddListViewModel(tasksListService: tasksListService)
        sut = AddListView(viewModel: viewModel)
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
    
    func testTextField_whenTextfieldIsCreated_shouldBeEmpty() {
        XCTAssertEqual(sut.titleTextfield.text, "")
    }
    
    func testAddListButton_whenThereIsNoTitle_shouldButtonBeDisabled() {
        XCTAssertFalse(sut.addListButton.isEnabled)
    }
    
    func testAddListButton_whenThereIsTitle_shouldButtonBeEnabled() {
        sut.titleTextfield.insertText("Test title")
        XCTAssertTrue(sut.addListButton.isEnabled)
    }
}

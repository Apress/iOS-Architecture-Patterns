//
//  TasksListServiceTest.swift
//  VIP_MyToDosTests
//
//  Created by Raúl Ferrer on 14/9/22.
//

import XCTest
import CoreData

@testable import VIP_MyToDos

class TasksListServiceTest: XCTestCase {
    
    var sut: TasksListServiceProtocol!
    var list: TasksListModel!
    
    override func setUpWithError() throws {
        sut = TasksListService(coreDataManager: InMemoryCoreDataManager())
        list = TasksListModel(id: "12345-67890",
                              title: "Test List",
                              icon: "test.icon",
                              tasks: [TaskModel](),
                              createdAt: Date())
    }
    
    override func tearDownWithError() throws {
        sut = nil
        list = nil
        super.tearDown()
    }
    
    func testSaveOnDB_whenSavesAList_shouldBeOneOnDatabase() {
        sut.saveTasksList(list)
        XCTAssertEqual(sut.fetchLists().count, 1)
    }
    
    
    func testSaveOnDB_whenSavesAList_shouldBeOneWithGivenIdOnDatabase() {
        sut.saveTasksList(list)
        XCTAssertNotNil(sut.fetchListWithId("12345-67890"))
    }
    
    
    func testDeleteOnDB_whenSavesAListAndThenDeleted_shouldBeNoneOnDatabase() {
        sut.saveTasksList(list)
        XCTAssertNotNil(sut.fetchListWithId("12345-67890"))
        sut.deleteList(list)
        XCTAssertEqual(sut.fetchLists().count, 0)
    }
}

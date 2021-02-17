//
//  AdriTests.swift
//  AdriTests
//
//  Created by José Mateus Azevedo on 13/08/20.
//  Copyright © 2020 José Mateus Azevedo. All rights reserved.
//

import XCTest
import CoreData
@testable import Adri

class AdriTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testSetsTableView() {
        let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let mainScreenController = storyboard.instantiateViewController(withIdentifier: "MainScreenController") as! MainScreenController

        _ = mainScreenController.view

        XCTAssertNotNil(mainScreenController.tableView)
    }

    func testPassDataMainToSavedController() {

    }

    func testNumberOfElementsOnTableAndDataBase() {
        let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let mainScreenController = storyboard.instantiateViewController(withIdentifier: "MainScreenController") as! MainScreenController
                _ = mainScreenController.view
        let numberOfRows = mainScreenController.tableView.numberOfRows(inSection: 0)

        var numberOfPersistingObjects = 0

        do {
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Medicine")
            numberOfPersistingObjects = try managedContext.fetch(fetchRequest).count
        } catch let error as NSError {
            print("Data could not fatch. \(error), \(error.userInfo)")
        }

        XCTAssertEqual(numberOfRows, numberOfPersistingObjects)
    }

}

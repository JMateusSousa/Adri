//
//  SavedMedicineViewControllerTests.swift
//  AdriTests
//
//  Created by José Mateus Azevedo on 11/02/21.
//  Copyright © 2021 José Mateus Azevedo. All rights reserved.
//

import XCTest
import UIKit

@testable import Adri

class SavedMedicineViewControllerTests: XCTestCase {

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

    func testTextOnTextViews() {
        let storyboard = UIStoryboard(name: "SavedMedicine", bundle: nil)
        let savedMedicineViewController = storyboard.instantiateViewController(withIdentifier: "SavedMedicine") as! SavedMedicineViewController
        _ = savedMedicineViewController.view

        savedMedicineViewController.textOne = "Teste 1"
        savedMedicineViewController.textTwo = "Teste 2"

        savedMedicineViewController.viewDidLoad()
        XCTAssertEqual(savedMedicineViewController.textOne, savedMedicineViewController.textViewIndicantion.text)
        XCTAssertEqual(savedMedicineViewController.textTwo, savedMedicineViewController.textViewContraindicantion.text)
        
    }

}

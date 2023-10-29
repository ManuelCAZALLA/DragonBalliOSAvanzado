//
//  ApiManagerTest.swift
//  DragonBalliOSAvanzadoTests
//
//  Created by Manuel Cazalla Colmenero on 29/10/23.
//

import XCTest
@testable import DragonBalliOSAvanzado

class ApiManagerTest: XCTestCase {
    private var apiManager: MockApiManager!
    
    override func setUp() {
        super.setUp()
        apiManager = MockApiManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testLogin() {
        let expectation = XCTestExpectation(description: "Login completion ")
        
        apiManager.login(user: "manuelcm23@hotmail.com", password: "131090") { result in
            switch result {
            case .success(let token):
                XCTAssertEqual(token, "TokenApiDragonBall")
            case .failure:
                XCTFail("Login should not fail")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 8.0)
        
    }
    
    func testGetHeroes() {
        let expectation = XCTestExpectation(description: "Get Heroes completion")
        
        apiManager.getHeroes(by: "Maestro Roshi", token: "TokenApiDragonBall" ) { result in
            switch result {
            case .success(let heroes):
                XCTAssertFalse(heroes.isEmpty)
                
                XCTAssertTrue(heroes.allSatisfy { $0.name == "Maestro Roshi" })
            case .failure:
                XCTFail("getHeroes should not fail")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 8.0)
    }
    
    func testGetLocations() {
        
        let expectation = XCTestExpectation(description: "Get Locations completion")
        
        apiManager.getLocations(by: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94", token: "TokenApiDragonBall") { result in
            switch result {
            case .success(let locations):
                XCTAssertFalse(locations.isEmpty)
                XCTAssertTrue(locations.allSatisfy { $0.hero?.id == "D13A40E5-4418-4223-9CE6-D2F9A28EBE94" })
            case .failure:
                XCTFail("getLocations should not fail")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 8.0)
    }
}

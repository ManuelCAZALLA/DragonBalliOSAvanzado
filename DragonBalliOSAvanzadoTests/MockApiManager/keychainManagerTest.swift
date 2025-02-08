//
//  keychainManagerTest.swift
//  DragonBalliOSAvanzadoTests
//
//  Created by Manuel Cazalla Colmenero on 29/10/24.
//

import XCTest
@testable import DragonBalliOSAvanzado

final class keychainManagerTest: XCTestCase {
    private var sut: KeychainManagerProtocol!
    
    override func setUp() {
        sut = KeychainManager()
    }
    
    override func tearDown() {
        
    }
    
    func testGetToken() {
        let token = "myToken"
        sut.save(token: token)
        let tokenReceived = sut.getToken()
        XCTAssertEqual(tokenReceived, token)
    }
    
    func testSaveToken() {
        let token = "Token"
        let tokenReceived = sut.getToken()
        XCTAssertNotEqual(tokenReceived, token)
    }
    
    
    func testDeleteToken() {
        let token = "myToken"
        sut.save(token: token)
        sut.deleteToken()
        let tokenReceived = sut.getToken()
        XCTAssertNil(tokenReceived)
    }
}








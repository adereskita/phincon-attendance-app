//
//  phincon_attendance_appTests.swift
//  phincon-attendance-appTests
//
//  Created by Satriya on 10/03/22.
//

import XCTest
import SwiftKeychainWrapper
@testable import phincon_attendance_app

class phincon_attendance_appTests: XCTestCase {
    
    var loginWorker: LoginWorker = LoginWorker()
    var dashboardWorker: DashboardWorker = DashboardWorker()
    
    let keyChainWrapper = KeychainWrapper.standard

    func testLoginApiResponse() throws {
        let e = expectation(description: "Login Function")
        let username = "2000000011-XXX"
        let password = "password"
        
        loginWorker.postLogin(username: username, password: password, completionHandler: { result in
            switch result {
            case .success(let value):
                XCTAssertNotNil(value)
                XCTAssertEqual(200, value.success.status!)
            case .failure(let error):
                print(error)
                XCTAssertNil(error)
            }
            e.fulfill()
        })
        wait(for: [e], timeout: 5.0)
    }
    
    func testUserSession() throws {
        let e = expectation(description: "User Session")
        let token = keyChainWrapper.string(forKey: "user_token")!
        print(token)
        XCTAssertNotNil(token)

        dashboardWorker.loginSession(token: token, completionHandler: { result in
            switch result {
            case .success(let value):
                XCTAssertNotNil(value)
            case .failure(let error):
                print(error)
                XCTAssertNil(error)
            }
            e.fulfill()
        })
        wait(for: [e], timeout: 5.0)
    }
}

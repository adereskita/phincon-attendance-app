//
//  LoginWorker.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 23/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginWorkerProtocol: AnyObject {
    func postLogin(username: String, password: String, completionHandler: @escaping (Result<LoginModels.Post.Response, APIError>) -> Void)
//    func postLogin(username: String, password:String, success: @escaping(_ response: LoginModels.Post.Response) -> Void, fail:@escaping(_ message: String) -> Void)
}

class LoginWorker: LoginWorkerProtocol {
    
    // MARK: - Private Properties
    private var service: ClientAPIProtocol
    
    // MARK: - Init
    init(_ service: ClientAPIProtocol = ClientAPI()) {
        self.service = service
    }
    
    func postLogin(username: String, password: String, completionHandler: @escaping (Result<LoginModels.Post.Response, APIError>) -> Void) {
        service.postLogin(username: username, password: password) { (result) in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(APIError(status: error.status, message: error.message)))
            }
//                completionHandler(result)
        }
    }
}

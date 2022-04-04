//
//  ClientAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation

protocol ClientAPIProtocol {
    func postLogin(username: String, password: String, completionHandler: @escaping (Result<LoginModels.Post.Response, NSError>) -> Void)
    func postRegister(username: String, fullname: String, password: String, completionHandler: @escaping (Result<RegisterModels.Post.Response, ErrorStatus>) -> Void)
//    func postLogin(username: String, password: String, completionHandler: @escaping (Result<[LoginModels.Post.Success], NSError>) -> Void)
}

class ClientAPI: BaseAPI<RouterAPI>, ClientAPIProtocol {
    func postRegister(username: String, fullname: String, password: String, completionHandler: @escaping (Result<RegisterModels.Post.Response, ErrorStatus>) -> Void) {
        
    }
    
    
    func postLogin(username: String, password: String, completionHandler: @escaping (Result<LoginModels.Post.Response, NSError>) -> Void) {
        self.fetchData(target: .postLogin(username: "2000000011-XXX", password: password), responseClass: LoginModels.Post.Response.self) { (result) in
            
            if username.isEmpty, password.isEmpty {
                completionHandler(.failure(NSError()))
            } else {
                completionHandler(result)
            }
        }
    }
}

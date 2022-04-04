//
//  ClientAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation

protocol ClientAPIProtocol {
    func postLogin(username: String, password: String, completionHandler: @escaping (Result<[LoginModels.Post.Response], NSError>) -> Void)
}

class ClientAPI: BaseAPI<RouterAPI>, ClientAPIProtocol {
    
    func postLogin(username: String, password: String, completionHandler: @escaping (Result<[LoginModels.Post.Response], NSError>) -> Void) {
        self.fetchData(target: .postLogin(username: "2000000011-XXX", password: "password"), responseClass: [LoginModels.Post.Response].self) { (result) in
            completionHandler(result)
        }
    }
}

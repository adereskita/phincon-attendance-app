//
//  RouterAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation
import Alamofire

enum RouterAPI {
    case getUser(username: String)
    case postRegister(username: String)
    case postLogin(username: String, password: String)
}

extension RouterAPI: TargetType {
    var baseURL: String {
        switch self {
        default:
            return ConstantAPI.Server.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .postLogin:
            return "/authentication"
        case .getUser:
            return "/user-profile"
        case .postRegister:
            return "/registration"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUser:
            return .get
        case .postLogin:
            return .post
        case .postRegister:
            return .post
        }
    }
    
//    var encoding: ParameterEncoding = {
//        switch method {
//        case .get:
//            return URLEncoding.default
//        default:
//            return JSONEncoding.default
//        }
//    }()
    
    var task: Task {
        switch self {
        case .postLogin(let username, let password):
            return .requestParameters(parameters: [RegisterModels.Post.Request.username: username, RegisterModels.Post.Request.password: password], encoding: JSONEncoding.default)
        case .postRegister:
            return .requestPlain
        case .getUser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [ConstantAPI.HttpHeaderField.contentType.rawValue: ConstantAPI.ContentType.json.rawValue,
//                    ConstantAPI.HttpHeaderField.acceptEncoding.rawValue: "gzip, deflate, br",
                    ConstantAPI.HttpHeaderField.apikey.rawValue: ConstantAPI.Server.apiKey
            ]
        }
    }
    
}

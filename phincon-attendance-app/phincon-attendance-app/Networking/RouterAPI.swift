//
//  RouterAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation
import Alamofire

enum RouterAPI {
    case getUser(token: String)
    case postRegister(username: String, password: String, fullname: String, idnumber: String)
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
    
    var task: Task {
        switch self {
        case .postLogin(let username, let password):
            return .requestParameters(parameters: [ConstantAPI.Parameters.username: username, ConstantAPI.Parameters.password: password], encoding: JSONEncoding.default)
        case .postRegister(let username, let password, let fullname, let idnumber):
            return .requestParameters(parameters: [ConstantAPI.Parameters.username: username,
                                                    ConstantAPI.Parameters.password: password,
                                                    ConstantAPI.Parameters.fullname: fullname,
                                                    ConstantAPI.Parameters.idcardnumber: idnumber],
                                      encoding: JSONEncoding.default)
        case .getUser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUser(let token):
            return [ConstantAPI.HttpHeaderField.contentType.rawValue: ConstantAPI.ContentType.json.rawValue,
                   ConstantAPI.HttpHeaderField.apikey.rawValue: ConstantAPI.Server.apiKey,
                   ConstantAPI.HttpHeaderField.authentication.rawValue: "Bearer " + token // space after Bearer important
           ]
        default:
            return [ConstantAPI.HttpHeaderField.contentType.rawValue: ConstantAPI.ContentType.json.rawValue,
                    ConstantAPI.HttpHeaderField.apikey.rawValue: ConstantAPI.Server.apiKey
            ]
        }
    }
    
}

//
//  RouterAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation
import Alamofire

enum RouterAPI {
    case getSplashScreen
    case onBoarding
    case getUser(token: String)
    case postRegister(username: String, password: String, fullname: String, idnumber: String)
    case postLogin(username: String, password: String)
    case checkIn(location: String, token: String)
    case checkOut(location: String, token: String)
    case getLocation(token: String)
    case getHistory(logs: String, token: String)
    case putEditProfile(token: String, fullname: String, idcardnumber: String, address: String)
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
        case .getSplashScreen:
            return "/splashscreen"
        case .onBoarding:
            return "/onboarding"
        case .postLogin:
            return "/authentication"
        case .getUser:
            return "/user-profile"
        case .postRegister:
            return "/registration"
        case .checkIn:
            return "/check-in"
        case .checkOut:
            return "/check-out"
        case .getLocation:
            return "/user-location"
        case .getHistory(let logs,_):
            return "/history?log=\(logs)"
        case .putEditProfile:
            return "/user-change-profile"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSplashScreen:
            return .get
        case .onBoarding:
            return .get
        case .getUser:
            return .get
        case .postLogin:
            return .post
        case .postRegister:
            return .post
        case .checkIn:
            return .post
        case .checkOut:
            return .post
        case .getLocation:
            return .get
        case .getHistory:
            return .get
        case .putEditProfile:
            return .put
        }
    }
    
    var task: Task { //parameter
        switch self {
        case .getSplashScreen:
            return .requestPlain
        case .onBoarding:
            return .requestPlain
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
        case .checkIn(let location, _):
            return .requestParameters(parameters: [ConstantAPI.Parameters.location: location], encoding: JSONEncoding.default)
        case .checkOut(let location, _):
            return .requestParameters(parameters: [ConstantAPI.Parameters.location: location], encoding: JSONEncoding.default)
        case .getLocation:
            return .requestPlain
        case .getHistory:
            return .requestPlain
        case .putEditProfile(_, fullname: let fullname, idcardnumber: let idcardnumber, address: let address):
            return .requestParameters(parameters: [ ConstantAPI.Parameters.fullname: fullname, ConstantAPI.Parameters.idcardnumber: idcardnumber, ConstantAPI.Parameters.address: address], encoding: JSONEncoding.default)
            //            return .requestParameters(parameters: [ConstantAPI.Parameters.log: log], encoding: JSONEncoding.default)
        }
    }
    
    func headerWithToken(token: String) -> [String : String] {
        return [ConstantAPI.HttpHeaderField.contentType.rawValue: ConstantAPI.ContentType.json.rawValue,
                ConstantAPI.HttpHeaderField.apikey.rawValue: ConstantAPI.Server.apiKey,
                ConstantAPI.HttpHeaderField.authentication.rawValue: "Bearer " + token // space after Bearer important
        ]
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUser(let token):
            return headerWithToken(token: token)
        case .checkIn(_, let token):
            return headerWithToken(token: token)
        case .checkOut(_, let token):
            return headerWithToken(token: token)
        case .getLocation(let token):
            return headerWithToken(token: token)
        case .getHistory(_, let token):
            return headerWithToken(token: token)
        case .putEditProfile(let token, _, _, _):
            return headerWithToken(token: token)
        default:
            return [ConstantAPI.HttpHeaderField.contentType.rawValue: ConstantAPI.ContentType.json.rawValue,
                    ConstantAPI.HttpHeaderField.apikey.rawValue: ConstantAPI.Server.apiKey
            ]
        }
    }
}

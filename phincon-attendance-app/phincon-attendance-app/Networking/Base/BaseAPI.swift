//
//  BaseAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation
import Alamofire

class BaseAPI<T:TargetType> {
    
    func fetchData<M: Codable>(target: T, responseClass: M.Type, completionHandler: @escaping (Result<M, NSError>)-> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseData {
            (response) in
            
            guard let statusCode = response.response?.statusCode else {
                print("StatusCode not found")
                completionHandler(.failure(NSError()))
                return
            }
            
            if statusCode == 200 {
//                guard let jsonResponse = try? response.result.get() else {
//                    print("jsonResponse error")
//                    completionHandler(.failure(NSError()))
//                    return
//                }
//                guard let theJSONData = try? JSONSerialization.data(withJSONObject: response.data, options: []) else {
//                    print("theJSONData error")
//                    completionHandler(.failure(NSError()))
//                    return
//                }
                guard let jsonData = response.data else {return}
                print(M.self)
                guard let responseObj = try? JSONDecoder().decode(M.self, from: jsonData) else {
                    print("responseObj Error")
                    completionHandler(.failure(NSError()))
                    return
                }
                completionHandler(.success(responseObj))
            } else {
                print("error statusCode: \(statusCode)")
                if let data = response.data {
                    let json = String(data: data, encoding: .utf8)
                    print("Failure Response: \(json)")
                }
                completionHandler(.failure(NSError()))
            }
        }
    }
    
//    func postData<M: Decodable>(target: T, responseClass: M.Type, completionHandler: @escaping (Result<M, NSError>)-> Void) {
//        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
//        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
//        let parameters = buildParams(task: target.task)
//
//        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).uploadProgress {
//            (progress) in}.responseJSON {
//                (response) in
//
//                if response.error ==  nil {
//
//                    var responseData: String?
//
//                    if response.data != nil {
//                        responseData = String(bytes: response.data!, encoding: .utf8)
//                    } else {
//                        responseData = response.response?.description
//                    }
//
//                    print(responseData)
//                }
//
//        }
//
//    }
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}

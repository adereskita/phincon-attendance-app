//
//  BaseAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation
import Alamofire

class BaseAPI<T:TargetType> {
    
    func fetchData<M: Codable>(target: T, responseClass: M.Type, completionHandler: @escaping (Result<M, APIError>)-> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseData {
            (response) in
            
            guard let statusCode = response.response?.statusCode else {
                print("StatusCode not found")
                completionHandler(.failure(APIError(status: 0, message: "StatusCode not found")))
                return
            }
            
            if statusCode == 200 {
                guard let jsonData = response.data else {
                    print("jsonResponse error")
                    completionHandler(.failure(APIError(status: statusCode, message: "jsonResponse error")))
                    return
                }
                do {
                    let responseCodableObject = try JSONDecoder().decode(M.self, from: jsonData)
                    completionHandler(.success(responseCodableObject))
                } catch let error {
                    print("Parsing Error: \(error)")
                    completionHandler(.failure(APIError(status: statusCode, message: "Parsing Error: \(error)")))
                }
                
            } else {
                print("error statusCode: \(statusCode)")
                if let data = response.data {
                    // MARK: Decode Api Error Response
                    guard let responseJSON = try? JSONDecoder().decode(ResponseError.self, from: data) else {
                        print("Response JSON Failed")
                        completionHandler(.failure(APIError(status: statusCode, message: "Error \(statusCode)")))
                        return
                    }
                    completionHandler(.failure(APIError(status: statusCode, message: responseJSON.error.message)))
                }
            }
        }
    }
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}

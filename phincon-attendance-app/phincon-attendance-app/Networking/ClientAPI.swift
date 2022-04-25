//
//  ClientAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation

protocol ClientAPIProtocol {
    func postLogin(username: String, password: String, completionHandler: @escaping (Result<LoginModels.Post.Response, APIError>) -> Void)
    func postRegister(username: String, fullname: String, password: String, idnumber: String, completionHandler: @escaping (Result<RegisterModels.Post.Response, APIError>) -> Void)
    //    func postLogin(username: String, password: String, completionHandler: @escaping (Result<[LoginModels.Post.Success], NSError>) -> Void)
}

protocol ClientAPIOnboardingProtocol {
    func getOnboarding(completionHandler: @escaping (Result<OnBoardingModels.FetchOnBoarding.Response, APIError>) -> Void)
}

protocol ClientAPIDashboardProtocol {
    func loginSession(token: String, completionHandler: @escaping (Result<DashboardModels.IsLogin.Response, APIError>) -> Void)
    func checkIn(location: String, token: String, completionHandler: @escaping (Result<DashboardModels.CheckLocation.Response, APIError>) -> Void)
    func checkOut(location: String, token: String, completionHandler: @escaping (Result<DashboardModels.CheckLocation.Response, APIError>) -> Void)
    func getLocation(token: String, completionHandler: @escaping (Result<DashboardModels.GetLocation.Response, APIError>) -> Void)
}

protocol ClientAPIHistoryProtocol {
    func getHistory(log: String, token: String, completionHandler: @escaping (Result<HistoryModel.FetchHistory.Response, APIError>) -> Void)
}

protocol ClientAPIProfileProtocol {
    func getProfile(token: String, completionHandler: @escaping (Result<ProfilModels.LoadProfil.Response, APIError>) -> Void)
}

class ClientAPI: BaseAPI<RouterAPI>, ClientAPIProtocol {
    
    func postRegister(username: String, fullname: String, password: String, idnumber: String, completionHandler: @escaping (Result<RegisterModels.Post.Response, APIError>) -> Void) {
        self.fetchData(target: .postRegister(username: username, password: password, fullname: fullname, idnumber: idnumber), responseClass: RegisterModels.Post.Response.self, completionHandler: { result in
            completionHandler(result)
        })
    }
    
    func postLogin(username: String, password: String, completionHandler: @escaping (Result<LoginModels.Post.Response, APIError>) -> Void) {
        self.fetchData(target: .postLogin(username: username, password: password), responseClass: LoginModels.Post.Response.self, completionHandler: { (result) in
            if username.isEmpty, password.isEmpty {
                completionHandler(.failure(APIError(status: -1, message: "Username or Password is required")))
            } else {
                completionHandler(result)
            }
        })
    }
}

// MARK: ClientAPIOnboardingProtocol
extension ClientAPI: ClientAPIOnboardingProtocol {
    func getOnboarding(completionHandler: @escaping (Result<OnBoardingModels.FetchOnBoarding.Response, APIError>) -> Void) {
        self.fetchData(target: .onBoarding, responseClass: OnBoardingModels.FetchOnBoarding.Response.self, completionHandler: { result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}

// MARK: ClientAPIDashboardProtocol
extension ClientAPI: ClientAPIDashboardProtocol {
    
    func getLocation(token: String, completionHandler: @escaping (Result<DashboardModels.GetLocation.Response, APIError>) -> Void) {
        self.fetchData(target: .getLocation(token: token), responseClass: DashboardModels.GetLocation.Response.self, completionHandler: { result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func checkIn(location: String, token: String, completionHandler: @escaping (Result<DashboardModels.CheckLocation.Response, APIError>) -> Void) {
        self.fetchData(target: .checkIn(location: location, token: token), responseClass: DashboardModels.CheckLocation.Response.self , completionHandler: { result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func checkOut(location: String, token: String, completionHandler: @escaping (Result<DashboardModels.CheckLocation.Response, APIError>) -> Void) {
        self.fetchData(target: .checkOut(location: location, token: token), responseClass: DashboardModels.CheckLocation.Response.self, completionHandler: {
            result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    
    func loginSession(token: String, completionHandler: @escaping (Result<DashboardModels.IsLogin.Response, APIError>) -> Void) {
        self.fetchData(target: .getUser(token: token), responseClass: DashboardModels.IsLogin.Response.self, completionHandler: { result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}

// MARK: ClientAPIHistoryProtocol
extension ClientAPI: ClientAPIHistoryProtocol {
    
    func getHistory(log: String, token: String, completionHandler: @escaping (Result<HistoryModel.FetchHistory.Response, APIError>) -> Void) {
        self.fetchData(target: .getHistory(logs: log, token: token), responseClass: HistoryModel.FetchHistory.Response.self, completionHandler: { result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}

extension ClientAPI : ClientAPIProfileProtocol {
    func getProfile(token: String, completionHandler: @escaping (Result<ProfilModels.LoadProfil.Response, APIError>) -> Void) {
        self.fetchData(target: .getUser(token: token), responseClass: ProfilModels.LoadProfil.Response.self, completionHandler: { result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}

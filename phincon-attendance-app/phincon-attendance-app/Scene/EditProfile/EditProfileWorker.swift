//
//  EditProfileWorker.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 30/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EditProfileWorkerProtocol: AnyObject {
    func putEditProfile(address: String, fullname: String, idcardnumber: String, completionHandler: @escaping (Result<EditProfileModel.Put.Response, APIError>) -> Void)
}
class EditProfileWorker : EditProfileWorkerProtocol {
    private var service: ClientAPIProtocol
    
    init(_ service: ClientAPIProtocol = ClientAPI()) {
        self.service = service
    }
    
    func putEditProfile(address: String, fullname: String, idcardnumber: String, completionHandler: @escaping (Result<EditProfileModel.Put.Response, APIError>) -> Void) {
        service.putEditProfile(address: address, fullname: fullname, idcardnumber: idcardnumber) {
            (result) in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(APIError(status: error.status, message: error.message)))
            }
        }
    }
    
//    var editProfile = [EditProfileData]()
//
//
//    func fetchEditProfile() -> [EditProfileData] {
//        editProfile = [EditProfileData(titleData: "New Address", descData: "Jakarta Selatan", iconData: UIImage(named: "book")),
//                       EditProfileData(titleData: "New Password", descData: "**********", iconData: UIImage(named: "password")),
//                       EditProfileData(titleData: "Repeat Password", descData: "**********", iconData: UIImage(named: "password"))
//        ]
//        return editProfile
//    }
}

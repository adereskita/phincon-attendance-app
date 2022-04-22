//
//  EditProfileInteractor.swift
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

protocol EditProfileBusinessLogic
{
    func editProfile(_ request: EditProfileModel.Put.Request)
}

protocol EditProfileDataStore
{
    //var name: String { get set }
}

class EditProfileInteractor: EditProfileBusinessLogic, EditProfileDataStore
{
    
    var presenter: EditProfilePresentationLogic?
    var worker: EditProfileWorker?
   
    
    // MARK: Do something
    func editProfile(_ request: EditProfileModel.Put.Request) {
        worker = EditProfileWorker()
        worker?.putEditProfile(username: request.username!, fullname: request.fullname!, idcardnumber: request.idcardnumber!, completionHandler: { (result) in
            switch result {
            case .success(let value):
                self.presenter?.interactor(didChange: value)
                print("Success Edit Profile")
            case .failure(let error):
                print(error.status, error.message)
                
            }
        })
    }
    
    
}

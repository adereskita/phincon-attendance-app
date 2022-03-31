//
//  EditProfilePresenter.swift
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

protocol EditProfilePresentationLogic
{
  func presentSomething(response: EditProfileModel.LoadEditProfile.Response)
}

class EditProfilePresenter: EditProfilePresentationLogic
{
  weak var viewController: EditProfileDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: EditProfileModel.LoadEditProfile.Response)
  {
      let response = EditProfileModel.LoadEditProfile.Response(Editdata: response.Editdata)
    viewController?.displaySomething(viewModel: response)
  }
}
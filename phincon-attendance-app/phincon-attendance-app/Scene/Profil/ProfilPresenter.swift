//
//  ProfilPresenter.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 23/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProfilPresentationLogic
{
  func presentSomething(response: ProfilModel.LoadProfil.Response)
}

class ProfilPresenter: ProfilPresentationLogic
{
  weak var viewController: ProfilDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ProfilModel.LoadProfil.Response)
  {
      let response = ProfilModel.LoadProfil.Response(ProfileData: response.ProfileData, ProfilePicture: response.ProfilePicture)
    viewController?.displaySomething(profile: response)
  }
}

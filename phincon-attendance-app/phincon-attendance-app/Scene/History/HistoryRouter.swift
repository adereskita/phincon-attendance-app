//
//  HistoryRouter.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/22/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol HistoryRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HistoryDataPassing
{
  var dataStore: HistoryDataStore? { get }
}

class HistoryRouter: NSObject, HistoryRoutingLogic, HistoryDataPassing
{
  weak var viewController: HistoryViewController?
  var dataStore: HistoryDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: HistoryViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: HistoryDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

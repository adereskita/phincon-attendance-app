//
//  EditProfileViewController.swift
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

protocol EditProfileDisplayLogic: AnyObject
{
    func presenter(didChange response: EditProfileModel.Put.Response)
    func presenter(didFailedChange message: String)
}

class EditProfileViewController: UIViewController, EditProfileDisplayLogic
{
  var interactor: EditProfileBusinessLogic?
  var router: (NSObjectProtocol & EditProfileRoutingLogic & EditProfileDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = EditProfileInteractor()
    let presenter = EditProfilePresenter()
    let router = EditProfileRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var tableView : UITableView!
    var data : [EditProfileData] = []
    
    func setupView() {
        saveButton.backgroundColor = colorUtils.darkBlue
        saveButton.tintColor = UIColor.white
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.textAlignment = .center
        saveButton.layer.cornerRadius = 8
            
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EditProfileTableViewCell.nib(), forCellReuseIdentifier: EditProfileTableViewCell.identifier)
    }
    
  func doSomething()
  {
    let request = EditProfileModel.Put.Request()
    interactor?.editProfile(request)
    setupView()
  }
  
  func displaySomething(viewModel: EditProfileModel.LoadEditProfile.Response)
  {
    //nameTextField.text = viewModel.name
      data = viewModel.Editdata
  }
    @IBAction func backButton(_sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButton(_sender: Any){
        self.dismiss(animated: true)
    }
}

extension EditProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileTableViewCell.identifier, for: indexPath) as! EditProfileTableViewCell
        let profilObject = data[indexPath.row]
        cell.setupCell(with: profilObject)
        return cell
    }
}

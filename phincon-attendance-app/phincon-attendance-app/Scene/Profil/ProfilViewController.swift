//
//  ProfilViewController.swift
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
protocol ProfilDisplayLogic: AnyObject {
    func presenter(getProfile response: ProfilModels.LoadProfil.Response)
    func presenter(getProfileBio response: ProfilModels.LoadProfil.Response)
}

class ProfilViewController: UIViewController, ProfilDisplayLogic {
    
    var interactor: ProfilBusinessLogic?
    var router: (NSObjectProtocol & ProfilRoutingLogic & ProfilDataPassing)?
    
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
        let interactor = ProfilInteractor()
        let presenter = ProfilPresenter()
        let router = ProfilRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileData()
        
    }
    
    // MARK: Do something
    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton : UIButton!
    
    var getProfile: [Users] = [Users]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var getProfileBio: [Users] = [Users]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    func setupProfil(){
        tableView.register(ProfilTableViewCell.nib(), forCellReuseIdentifier: ProfilTableViewCell.identifier)
        tableView.register(ProfilePictureTableViewCell.nib(), forCellReuseIdentifier: ProfilePictureTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 72
        tableView.layer.cornerRadius = 18
    }
    
    func fetchProfileData() {
        let request = ProfilModels.LoadProfil.Request()
        interactor?.loadProfile(request: request)
        interactor?.loadProfileBio(request: request)
        setupProfil()
    }
    
    func presenter(getProfile response: ProfilModels.LoadProfil.Response) {
        getProfile.append(_ : response.success.result!)
    }
    func presenter(getProfileBio response: ProfilModels.LoadProfil.Response) {
        getProfileBio.append(_ : response.success.result!)
    }
    @IBAction func profileMenu(_ sender:Any) {
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let editProfile = UIAlertAction(title: "Edit Profile", style: .default) { (action: UIAlertAction) in
            self.router?.routeToEditProfilePage(segue: nil)
        }
        let logoutUser = UIAlertAction(title: "Logout", style: .destructive) { (action: UIAlertAction) in
            self.userDefault.set(nil, forKey: "user_token")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let onboardingNavController = storyboard.instantiateViewController(identifier: "NavigationController")// root VC of Onboard
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(onboardingNavController)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        menuAlert.addAction(editProfile)
        menuAlert.addAction(logoutUser)
        menuAlert.addAction(cancelAction)
        self.present(menuAlert, animated: true, completion: nil)
    }
    
}
extension ProfilViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return getProfile.count
        }else {
            return getProfileBio.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: ProfilePictureTableViewCell.identifier, for: indexPath) as! ProfilePictureTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilTableViewCell.identifier, for: indexPath) as! ProfilTableViewCell

        if indexPath.section == 0 {
            let profilObject = getProfile[indexPath.row]
            cellHeader.setupprofileImage(with: profilObject)
            return cellHeader
        } else if indexPath.section == 1{
            let profilObject = getProfileBio[indexPath.row]
            cell.setupProfilView(with: profilObject)
            return cell
        } else if indexPath.section == 2 {
            let profilObject = getProfileBio[indexPath.row]
            cell.setupAddress(with: profilObject)
            return cell
        } else {
            let profilObject = getProfileBio[indexPath.row]
            cell.setupPassword(with: profilObject)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

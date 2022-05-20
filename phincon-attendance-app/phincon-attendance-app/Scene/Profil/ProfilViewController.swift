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
import SwiftKeychainWrapper

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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfil()
        fetchProfileData()
    }
    
    override func loadView() {
        super.loadView()
        setupViewNib()
    }
    
    // MARK: Do something
//    let userDefault = UserDefaults.standard
    let keyChainWrapper = KeychainWrapper.standard
    weak var profileView: ProfileView!

    var getProfile: [Users] = [Users]() {
        didSet {
            self.profileView.tableView.reloadData()
        }
    }
    
    var getProfileBio: [Users] = [Users]() {
        didSet {
            self.profileView.tableView.reloadData()
        }
    }
    
    func setupViewNib() {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        let profileViews = ProfileView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.view = profileViews
//        self.view.addview(dashboardViews)
        self.profileView = profileViews
        
        self.profileView.navBar.delegate = self
    }
    
    func setupProfil(){
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        
        profileView.tableView.refreshControl = UIRefreshControl()
        profileView.tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    func fetchProfileData() {
        let request = ProfilModels.LoadProfil.Request()
        interactor?.loadProfile(request: request)
        interactor?.loadProfileBio(request: request)
    }
    
    func presenter(getProfile response: ProfilModels.LoadProfil.Response) {
        self.getProfile.removeAll()
        getProfile.append(_ : response.success.result!)
    }
    
    func presenter(getProfileBio response: ProfilModels.LoadProfil.Response) {
        self.getProfileBio.removeAll()
        getProfileBio.append(_ : response.success.result!)
    }
    
    @objc func didPullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.fetchProfileData()
            self.profileView.tableView.refreshControl?.endRefreshing()
        }
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
        if indexPath.section == 3 {
            self.router?.routeToChangePassword(segue: nil)
        }else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension ProfilViewController: NavBarButtonDelegate {
    func didTapNotif() {
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let editProfile = UIAlertAction(title: "Edit Profile", style: .default) { (action: UIAlertAction) in
            self.router?.routeToEditProfilePage(segue: nil)
        }
        let logoutUser = UIAlertAction(title: "Logout", style: .destructive) { (action: UIAlertAction) in
            self.keyChainWrapper.removeObject(forKey: "user_token")
            self.router?.routeToLogoutUser(segue: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        menuAlert.addAction(editProfile)
        menuAlert.addAction(logoutUser)
        menuAlert.addAction(cancelAction)
        self.present(menuAlert, animated: true, completion: nil)
    }
}

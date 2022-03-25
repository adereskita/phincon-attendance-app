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
protocol ProfilDisplayLogic: AnyObject
{
    func displaySomething(profile: ProfilModel.LoadProfil.Response)
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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchProfileData()
        
    }
    
    // MARK: Do something
    
    
    var profileData: [Profile] = []
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    func setupProfil(){
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowRadius = 3.0
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        
        profileImage.layer.cornerRadius = 10
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        
        tableView.register(ProfilTableViewCell.nib(), forCellReuseIdentifier: ProfilTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 72
    }
    
    func fetchProfileData()
    {
        let request = ProfilModel.LoadProfil.Request()
        interactor?.doSomething(request: request)
        setupProfil()
    }
    
    func displaySomething(profile: ProfilModel.LoadProfil.Response)
    {
        profileData = profile.ProfileData
    }
}
extension ProfilViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilTableViewCell.identifier, for: indexPath) as! ProfilTableViewCell
        let profilObject = profileData[indexPath.row]
        cell.setupProfilView(with: profilObject)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ratio = UIScreen.main.bounds.height / 736
        return tableView.estimatedRowHeight * ratio
    }
    
}

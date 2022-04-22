//
//  DashboardViewController.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/24/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DashboardDisplayLogic: AnyObject {
    func presenter(didLoadCheckOutLoc response: DashboardModels.GetLocation.Response)
    func presenter(didLoadCheckInLoc response: DashboardModels.GetLocation.Response)
    func presenter(didCheckIn response: DashboardModels.CheckLocation.Response)
    func presenter(didCheckOut response: DashboardModels.CheckLocation.Response)

    func presenter(didFailedCheck status: Int, message: String)
    func presenter(expiredLoginSession status: Int, message: String)
}

class DashboardViewController: UIViewController, DashboardDisplayLogic {
    
    var interactor: DashboardBusinessLogic?
    var router: (NSObjectProtocol & DashboardRoutingLogic & DashboardDataPassing)?

  // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
  // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter()
        let router = DashboardRouter()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        isCheckOut = userDefault.bool(forKey: "isCheckOut")
        self.locationID = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let request = DashboardModels.IsLogin.Request()
        interactor?.checkLoginSession(request: request)
    }
  
  // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDashboard()
//        let request = DashboardModels.IsLogin.Request()
//        interactor?.checkLoginSession(request: request)
    }
      
    @IBOutlet var dashboardTableView: UITableView!
    @IBOutlet var checkInBtn: UIButton!
    @IBOutlet var circleBg: UIImageView!
    @IBOutlet var topCardView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var notificationBtn: UIButton!
    
    var timer = Timer()
    let userDefault = UserDefaults.standard
    
    var locationID  = ""
    var isCheckOut: Bool = false {
        didSet {
            if isCheckOut {
                checkInBtn.setTitle("CHECK OUT", for: .normal)
                circleBg.tintColor = UIColor(red: 0.969, green: 0.71, blue: 0, alpha: 1)
                dashboardTableView.reloadData()
            } else {
                checkInBtn.setTitle("CHECK IN", for: .normal)
                circleBg.tintColor = UIColor(red: 0.066, green: 0.752, blue: 0.302, alpha: 1)
                dashboardTableView.reloadData()
            }
        }
    }
    var checkInLists: [Location] = [Location]() {
        // to get data on start
        didSet {
//            DispatchQueue.main.async {
                self.dashboardTableView.reloadData()
//            }
        }
    }
    var checkOutLists: [Location] = [Location]() {
        // to get data on start
        didSet {
            self.dashboardTableView.reloadData()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
  
    func setDashboard() {
        let request = DashboardModels.GetLocation.Request()
        interactor?.loadCheckInList(request: request)
        interactor?.loadCheckOutList(request: request)
        setupUI()
    }
    
    func setupUI() {
        spinner.isHidden = true
        dashboardTableView.register(DashboardTableCell.nib(), forCellReuseIdentifier: DashboardTableCell.identifier)
        dashboardTableView.separatorStyle = .none
        dashboardTableView.delegate = self
        dashboardTableView.dataSource = self
        dashboardTableView.estimatedRowHeight = 76
        dashboardTableView.refreshControl = UIRefreshControl()
        dashboardTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        checkInBtn.titleLabel?.textAlignment = .center
        checkInBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        checkInBtn.titleLabel?.minimumScaleFactor = 0.5
        
        circleBg.layer.shadowColor = UIColor.lightGray.cgColor
        circleBg.layer.shadowOffset = CGSize.zero
        circleBg.layer.shadowOpacity = 0.4
        circleBg.layer.shadowRadius = 10.0

        topCardView.layer.cornerRadius = 20
        topCardView.layer.shadowColor = UIColor.lightGray.cgColor
        topCardView.layer.shadowOffset = CGSize.zero
        topCardView.layer.shadowOpacity = 0.2
        topCardView.layer.shadowRadius = 3.0
    
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        let dates = df.string(from: date)
        dateLabel.text = dates

        getCurrentTime()
    }
    
    private func getCurrentTime() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.currentTime) , userInfo: nil, repeats: true)
    }
    
    @objc func currentTime() {
//        df.dateFormat = "HH:mm"
//        let hour = df.string(from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        timeLabel.text = "Hour: \(formatter.string(from: Date()))"
    }
    
    func spinnerSetup(isSucces: Bool, message: String?) {
        self.view.isUserInteractionEnabled = false
        spinner.isHidden = false
        spinner.style = .medium
        spinner.backgroundColor = UIColor(white: 0.9, alpha: 0.6)
        spinner.layer.cornerRadius = 10.0
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.spinner.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.view.isUserInteractionEnabled = true
                self.alertSetup(isSucces: isSucces, error: message)
            }
        }
    }
    func alertSetup(isSucces: Bool, error message: String?) {
        if isSucces {
            let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error Occured", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Update from Presenter
    func presenter(didCheckOut response: DashboardModels.CheckLocation.Response) {
        let msg = "Check-Out was successful"
        spinnerSetup(isSucces: true, message: msg)
    }
    
    func presenter(didCheckIn response: DashboardModels.CheckLocation.Response) {
        let msg = "Check-in was successful"
        spinnerSetup(isSucces: true, message: msg)
    }
    
    func presenter(didLoadCheckInLoc response: DashboardModels.GetLocation.Response) {
        checkInLists.append(contentsOf: response.success.result!)
    }
    
    func presenter(didLoadCheckOutLoc response: DashboardModels.GetLocation.Response) {
        checkOutLists.append(contentsOf: response.success.result!)
    }
    
    func presenter(didFailedCheck status: Int, message: String) {
        let alert = UIAlertController(title: "Network Problem", message: "No Connection", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        if isCheckOut {
            userDefault.set(false, forKey: "isCheckOut")
            isCheckOut = userDefault.bool(forKey: "isCheckOut")
            if !Connectivity.isConnectedToInternet {
                self.present(alert, animated: true, completion: nil)
            } else {
                spinnerSetup(isSucces: false, message: "There is problem with your Location.")
            }
        } else {
            userDefault.set(true, forKey: "isCheckOut")
            isCheckOut = userDefault.bool(forKey: "isCheckOut")
            if !Connectivity.isConnectedToInternet {
                self.present(alert, animated: true, completion: nil)
            } else {
                spinnerSetup(isSucces: false, message: "There is problem with your Location.")
            }
        }
    }
    
    func presenter(expiredLoginSession status: Int, message: String) {
        if status == 403 {
            userDefault.set(nil, forKey: "user_token")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let onboardingNavController = storyboard.instantiateViewController(identifier: "NavigationController")// root VC of Onboard

            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(onboardingNavController)
        } else {
            if !Connectivity.isConnectedToInternet {
                let alert = UIAlertController(title: "Network Problem", message: "No Connection", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Button Action
    @IBAction func btnNotificationClicked(_ sender: Any) {
        router?.routeToNotification(segue: nil)
    }
    
    @IBAction func btnCheckPressed(_ sender: Any) {
        // TODO: Get Location ID from tableview
        let request = DashboardModels.CheckLocation.Request(location: self.locationID)
        if self.locationID != "" {
            if isCheckOut {
                self.interactor?.checkOut(request: request)
                userDefault.set(false, forKey: "isCheckOut")
                isCheckOut = userDefault.bool(forKey: "isCheckOut")
                locationID = ""
            } else {
                self.interactor?.checkIn(request: request)
                userDefault.set(true, forKey: "isCheckOut")
                isCheckOut = userDefault.bool(forKey: "isCheckOut")
                locationID = ""
            }
            
        } else {
            let errMsg = "Please choose your location first"
            spinnerSetup(isSucces: false, message: errMsg)
        }
    }
    
    @objc func didPullToRefresh() {
        let request = DashboardModels.GetLocation.Request()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            if self.isCheckOut {
                self.checkOutLists.removeAll()
                self.interactor?.loadCheckOutList(request: request)
            } else {
                self.checkInLists.removeAll()
                self.interactor?.loadCheckInList(request: request)
            }
//            self.dashboardTableView.reloadData()
            self.dashboardTableView.refreshControl?.endRefreshing()
        }
    }
}


extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCheckOut {
            return checkOutLists.count
        } else {
            return checkInLists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableCell", for: indexPath) as! DashboardTableCell
        
        if isCheckOut {
            let listObj = checkOutLists[indexPath.row]
            cell.setDashboardCellView(listObj)
            cell.selectedColor = colorUtils.yellowCheckout
            cell.selectedColorLbl = .black
            
            return cell
        } else {
            let listObj = checkInLists[indexPath.row]
            cell.selectedColor = colorUtils.blueCheckout
            cell.setDashboardCellView(listObj)
            cell.selectedColorLbl = .white
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listObj = checkInLists[indexPath.row]
        self.locationID = listObj.id!
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let heightRatio = UIScreen.main.bounds.height / 736
//        let tableViewHeight = tableView.frame.size.height
        return tableView.estimatedRowHeight
//        return tableView.estimatedRowHeight * heightRatio
    }
}

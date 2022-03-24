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
//    func displayDashboardList(viewModel: Dashboard.Something.ViewModel)
    func displayDashboardListIn(response: DashboardModels.LoadCheckInOut.Response)
    func displayDashboardListOut(response: DashboardModels.LoadCheckInOut.Response)
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
        isCheckOut = userDefault.bool(forKey: "isCheckOut")
    }
  
  // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDashboard()
    }
      
    @IBOutlet var dashboardTableView: UITableView!
    @IBOutlet var checkInBtn: UIButton!
    @IBOutlet var notifBtn: UIButton!
    @IBOutlet var circleBg: UIImageView!
    @IBOutlet var topCardView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let userDefault = UserDefaults.standard
    
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
    var checkInLists: [Checkin] = []
    var checkOutLists: [Checkin] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
  
    func setDashboard() {
        setupUI()
        let request = DashboardModels.LoadCheckInOut.Request()
        interactor?.loadDashboardListIn(request: request)
        interactor?.loadDashboardListOut(request: request)
    }
    
    func setupUI() {
        dashboardTableView.register(DashboardTableCell.nib(), forCellReuseIdentifier: DashboardTableCell.identifier)
        dashboardTableView.separatorStyle = .none
        dashboardTableView.delegate = self
        dashboardTableView.dataSource = self
        dashboardTableView.estimatedRowHeight = 76
        
        checkInBtn.titleLabel?.textAlignment = .center
//        checkInBtn.titleEdgeInsets = UIEdgeInsets(top: 0,left: 4,bottom: 0,right: 4)
        checkInBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        checkInBtn.titleLabel?.minimumScaleFactor = 0.5
//        isCheckOut = boolValue
        
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
        df.dateFormat = "HH:mm"
        let hour = df.string(from: date)
        
        dateLabel.text = dates
        timeLabel.text = "Hour: \(hour)"
    }
    
    // MARK: Do something
    func displayDashboardListIn(response: DashboardModels.LoadCheckInOut.Response) {
    //nameTextField.text = viewModel.name
        checkInLists.append(contentsOf: response.checkInData)
    }
    
    func displayDashboardListOut(response: DashboardModels.LoadCheckInOut.Response) {
    //nameTextField.text = viewModel.name
        checkOutLists = response.checkInData
    }
    
    @IBAction func btnCheckPressed(_ sender: Any) {
        if isCheckOut {
            userDefault.set(false, forKey: "isCheckOut")
            isCheckOut = userDefault.bool(forKey: "isCheckOut")
        } else {
            userDefault.set(true, forKey: "isCheckOut")
            isCheckOut = userDefault.bool(forKey: "isCheckOut")
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
            
            return cell
        } else {
            let listObj = checkInLists[indexPath.row]
            cell.setDashboardCellView(listObj)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let heightRatio = UIScreen.main.bounds.height / 736
//        let tableViewHeight = tableView.frame.size.height
        return tableView.estimatedRowHeight
//        return tableView.estimatedRowHeight * heightRatio
    }
}

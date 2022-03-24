//
//  OnBoardingWorker.swift
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

class OnBoardingWorker {
    
    var onboardSlide = [Onboarding]()
    
    func fetchOnBoard() -> [Onboarding]{
        
        onboardSlide = [
            Onboarding(title: "DIGITAL ABSENSI",
                            description: "Kehadiran sistem absensi digital merupakan penemuan yang mampu menggantikan pencatatan data kehadiran secara manual", image: #imageLiteral(resourceName: "onboard-page1")),
            Onboarding(title: "ATTENDANCE SYSTEM", description: "Pengelolaan karyawan di era digital yang baik, menghasilkan karyawan terbaik pula, salah satunya absensi karyawan", image: #imageLiteral(resourceName: "onboard-page2")),
            Onboarding(title: "SELALU PAKAI MASKER", description: "Guna mencegah penyebaran virus Covid-19, Pemerintah telah mengeluarkan kebijakan Physical Distancing serta kebijakan bekerja, belajar, dan beribadah dari rumah.", image: #imageLiteral(resourceName: "onboard-page3"))
        ]
        return onboardSlide
  }
}

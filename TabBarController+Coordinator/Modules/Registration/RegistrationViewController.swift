//
//  RegistrationViewController.swift
//  TabBarController+Coordinator
//
//  Created by Mahmoud Abdul-wahab on 30/11/2021.
//  Copyright © 2020 Mahmoud Abdul-wahab. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var registrationLable: UILabel!
    
    var authenticationCoordinatore: AuthenticationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapShowTest(_ sender: Any) {
        authenticationCoordinatore?.trigger(route: .test)
    }
    @IBAction func didTapShowTabBar(_ sender: Any){
        authenticationCoordinatore?.trigger(route: .tabBar)
    }
    
    deinit {
        print("RegistrationViewController deinit")
    }
}

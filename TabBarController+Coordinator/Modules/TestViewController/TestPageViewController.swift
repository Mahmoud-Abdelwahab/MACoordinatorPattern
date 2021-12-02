//
//  TestPageViewController.swift
//  TabBarController+Coordinator
//
//  Created by Mahmoud Abdul-wahab on 30/11/2021.
//  Copyright © 2020 Mahmoud Abdul-wahab. All rights reserved.
//

import UIKit

class TestPageViewController: UIViewController {
    
    var authenticationCoordinatore: AuthenticationCoordinator?
    
    @IBOutlet weak var didTapDismiss: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapDismiss(_ sender: Any) {
        authenticationCoordinatore?.trigger(route: .dismiss)
    }
    
    deinit {
        print("TestPageViewController deinit")
    }
}

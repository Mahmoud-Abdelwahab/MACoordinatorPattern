//
//  AuthenticationCoordinator.swift
//  TabBarController+Coordinator
//
//  Created by Mahmoud Abdul-wahab on 30/11/2021.
//  Copyright © 2020 Mahmoud Abdul-wahab. All rights reserved.
//
import Foundation
import UIKit

//protocol LoginCoordinatorProtocol: Coordinator {
//    func showLoginViewController()
//}

enum NavigationType{
    case push
    case pop
    case present(presentationMode: UIModalPresentationStyle ,transitionMode: UIModalTransitionStyle)
}

enum LoginRouts{
    case login
    case register(id: Int)
    case test
    case tabBar
    case dismiss
}

class AuthenticationCoordinator: Coordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .auth }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setNavigationBarHidden(false, animated: true)
        trigger(route: .login)
    }
    
    deinit {
        print("AuthenticationCoordinator deinit")
    }
    
    
    func trigger(route: LoginRouts){
        switch route{
        case .login:
            let loginVC: LoginViewController = .init()
            loginVC.authenticationCoordinatore = self
            navigationController.pushViewController(loginVC, animated: true)
            
        case .register(_):
            let registrationVC: RegistrationViewController = .init()
            registrationVC.authenticationCoordinatore = self
            navigationController.pushViewController(registrationVC, animated: true)
        case .test:
            let testVC: TestPageViewController = .init()
            testVC.authenticationCoordinatore = self
            testVC.modalPresentationStyle = .fullScreen
            navigationController.present(testVC, animated: true, completion: nil)
            
        case .dismiss:
            navigationController.dismiss(animated: true, completion: nil)
        case .tabBar:
            self.finish()
        }
    }
}

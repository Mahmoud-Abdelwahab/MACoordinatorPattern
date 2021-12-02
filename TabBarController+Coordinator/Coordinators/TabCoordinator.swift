//
//  TabCoordinator.swift
//  TabBarController+Coordinator
//
//  Created by Mahmoud Abdul-wahab on 30/11/2021.
//  Copyright © 2020 Mahmoud Abdul-wahab. All rights reserved.
//

import UIKit

struct TabBarPageStyle{
    let index: Int
    let title: String
    let icone : UIImage?
    let tintColor: UIColor
}
protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPageStyle)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPageStyle?
}

class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController
    
    var type: CoordinatorType { .tab }
    
    var controllers: [UINavigationController]?
    // Let's define which pages do we want to add into tab bar
    let pages: [TabBarPageStyle] = [
        TabBarPageStyle(index: 0, title: "Ready", icone:  UIImage(systemName: "music.note.house.fill"), tintColor: UIColor.blue),
        TabBarPageStyle(index: 1, title: "Steady", icone: UIImage(systemName: "message.circle.fill"), tintColor: UIColor.blue),
        TabBarPageStyle(index: 2, title: "Go", icone:  UIImage(systemName: "paperplane.fill"), tintColor: UIColor.blue),
    ]
        .sorted(by: { $0.index < $1.index })
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        // Initialization of ViewControllers or these pages
        controllers = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]?) {
        /// Set delegate for UITabBarController
        tabBarController.delegate = self
        /// Assign page's controllers
        tabBarController.setViewControllers(tabControllers, animated: true)
        /// Let set index
        tabBarController.selectedIndex = 0
        /// Styling
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPageStyle) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem.init(title: page.title,
                                                     image: page.icone,
                                                     tag: page.index)
        
        switch page.index {
        case 0:
            // If needed: Each tab bar flow can have it's own Coordinator.
            let readyVC = ReadyViewController()
            readyVC.didSendEventClosure = { [weak self] event in
                guard let self = self else{return}
                self.readyRoutes(route: event, navigationControler: navController)
            }
            navController.pushViewController(readyVC, animated: true)
        case 1:
            let steadyVC = SteadyViewController()
            steadyVC.didSendEventClosure = { [weak self] event in
                guard let self = self else{return}
                self.steadyRoutes(route: event , navigationControler: navController)
            }
            navController.pushViewController(steadyVC, animated: true)
        case 2:
            let goVC = GoViewController()
            goVC.didSendEventClosure = { [weak self] event in
                guard let self = self else{return}
                self.goRoutes(route: event, navigationControler: navController)
            }
            navController.pushViewController(goVC, animated: true)
            
        default:
            break
        }
        
        return navController
    }
    
    func steadyRoutes(route: SteadyViewController.Event , navigationControler: UINavigationController){
        switch route {
        case .steady:
            self.selectPage(pages[2])
        case .test:
            let testVC: DetailsScreen = .init()
            navigationControler.pushViewController(testVC, animated: true)
        case .profile:
            break
        }
    }
    
    func readyRoutes(route: ReadyViewController.Event , navigationControler: UINavigationController){
        switch route {
        case .ready:
            self.selectPage(pages[1])
        }
    }
    
    func goRoutes(route: GoViewController.Event , navigationControler: UINavigationController){
        switch route {
        case .go:
            self.finish()
        }
    }
    
    func currentPage() -> TabBarPageStyle? {pages.first(where: {$0.index == tabBarController.selectedIndex})}
    
    func selectPage(_ page: TabBarPageStyle) {tabBarController.selectedIndex = page.index}
    
    func setSelectedIndex(_ index: Int) {
        guard let page =  pages.first(where: {$0.index == index}) else { return }
        tabBarController.selectedIndex = page.index
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // to keep every tab navigation controller only cotains one view controller
        controllers?.forEach({
            navController in
            navController.viewControllers = [navController.viewControllers[0]]
        })
    }
}

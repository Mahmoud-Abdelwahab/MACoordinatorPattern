//
//  SteadyViewController.swift
//  TabBarController+Coordinator
//
//  Created by Mahmoud Abdul-wahab on 30/11/2021.
//  Copyright © 2020 Mahmoud Abdul-wahab. All rights reserved.
//

import UIKit

class SteadyViewController: UIViewController {
    
    var didSendEventClosure: ((SteadyViewController.Event) -> Void)?
    
    private let steadyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Steady", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    private let testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Test Page", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(steadyButton)
        view.addSubview(testButton)
        
        steadyButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            steadyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            steadyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            steadyButton.widthAnchor.constraint(equalToConstant: 200),
            steadyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            testButton.topAnchor.constraint(equalTo: steadyButton.bottomAnchor, constant: 100),
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.widthAnchor.constraint(equalToConstant: 200),
            testButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        steadyButton.addTarget(self, action: #selector(didTapSteadyButton(_:)), for: .touchUpInside)
        testButton.addTarget(self, action: #selector(didTapShowTestButton(_:)), for: .touchUpInside)
    }
    
    deinit {
        print("SteadyViewController deinit")
    }
    
    @objc private func didTapSteadyButton(_ sender: Any) {
        didSendEventClosure?(.steady)
    }
    
    @objc private func didTapShowTestButton(_ sender: Any) {
        didSendEventClosure?(.test)
    }
}

extension SteadyViewController {
    enum Event {
        case steady
        case test
        case profile
    }
}

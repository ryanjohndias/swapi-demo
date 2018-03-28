//
//  SplashViewController.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Fetch data
        // TODO: Show activity after x seconds of waiting
        
    }
    
    // TODO: Temporary navigation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gotoHomeViewController()
    }

    // MARK: - Navigation
    
    func gotoHomeViewController() {
        if let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Navigation.homeViewController) as? HomeViewController {
            navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
}

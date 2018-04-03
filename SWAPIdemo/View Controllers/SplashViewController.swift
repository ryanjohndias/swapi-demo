//
//  SplashViewController.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Show the activity indicator after x seconds of loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.activityIndicator.startAnimating()
        })
        
        // Fetch and persist the film data
        APIManager.shared.getFilms(success: { filmsResponse in
            self.gotoHomeViewController()
        }) { error in

            // Go to home anyway - data will be retrieved from local cache
            self.gotoHomeViewController()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Navigation
    
    func gotoHomeViewController() {
        if let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Navigation.homeViewController) as? HomeViewController {
            navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
}

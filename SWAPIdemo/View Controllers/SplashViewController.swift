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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        APIManager.shared.getFilms(success: { filmsResponse in
            self.gotoHomeViewController()
        }) { error in
            
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Navigation
    
    func gotoHomeViewController() {
        if let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Navigation.homeViewController) as? HomeViewController {
            navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
}

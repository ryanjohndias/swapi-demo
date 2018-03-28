//
//  HomeViewController.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Class vars
    
    var films: [Film] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        // Table view setup
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 168
        
        // FIXME: Temporarily fetching the data here
        APIManager.shared.getFilms(success: { filmsResponse in
            
            let releaseDateFormatter = DateFormatter()
            releaseDateFormatter.dateFormat = "YYYY-mm-dd"
            self.films = filmsResponse.results.sorted(by: { (film1, film2) -> Bool in
                
                let date1 = releaseDateFormatter.date(from: film1.releaseDate)
                let date2 = releaseDateFormatter.date(from: film2.releaseDate)
                
                if let date1 = date1, let date2 = date2 {
                    return date1.compare(date2) == .orderedAscending
                } else {
                    return true
                }
                
            })
            self.tableView.reloadData()
        }) { error in
            print(error)
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Navigation.homeTableViewCell, for: indexPath) as! HomeTableViewCell
        
        let film = films[indexPath.row]
        
        cell.titleLabel.text = film.title
        cell.releaseDateLabel.text = film.releaseDate
        cell.directorLabel.text = film.director
        cell.producersLabel.text = film.producer
        
        // FIXME: Temporary call location
        APIManager.shared.searchOMDB(for: film.title, success: { omdbFilm in
            cell.mainImageView.loadImage(fromURL: omdbFilm.Poster)
        }) { error in
            
        }
        
        return cell
    }
    
    
    
    
}

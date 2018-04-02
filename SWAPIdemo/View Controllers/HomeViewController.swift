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
    
    var films: [CDFilm] = []
    var releaseDateFormatter = DateFormatter(withFormat: "yyyy-MM-dd")
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        // Table view setup
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 168
        
        CoreDataManager.shared.fetchFilms(success: { (films) in
            
            self.films = films.sorted(by: { (film1, film2) -> Bool in

                if let date1 = film1.releaseDate as Date?, let date2 = film2.releaseDate as Date? {
                    return date1.compare(date2) == .orderedAscending
                } else {
                    return false
                }
            })
            
            self.tableView.reloadData()
            
        }, failure: { (error) in
            
        })
        
    }

    // MARK: - Navigation
    
    func gotoFilm(_ film: CDFilm) {
        
        if let filmViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Navigation.filmViewController) as? FilmViewController {
            filmViewController.film = film
            navigationController?.pushViewController(filmViewController, animated: true)
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
        cell.directorLabel.text = film.director
        cell.producersLabel.text = film.producer
        if let releaseDate = film.releaseDate as Date? {
            cell.releaseDateLabel.text = releaseDateFormatter.string(from: releaseDate)
        }
        cell.mainImageView.image = nil
        if let imageUrl = film.imageUrl {
            cell.mainImageView.loadImage(fromURL: imageUrl)
        }
 
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let film = films[indexPath.row]
        gotoFilm(film)
    }
}

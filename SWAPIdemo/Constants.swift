//
//  Constants.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

enum Constants {

    enum Configuration {
        
        static let omdbApiKey = "4f3ff90a"
    }
    
    enum API {
        
        static let baseUrl = "https://swapi.co/api/"
        
        static let omdbSearchUrl = "http://www.omdbapi.com/?s={searchTerm}&y=&plot=short&r=json&apikey=\(Constants.Configuration.omdbApiKey)"
        static let omdbMovieUrl = "http://www.omdbapi.com/?i={imdbId}&y=&plot=short&r=json&apikey=\(Constants.Configuration.omdbApiKey)"
    }
    
    enum CoreData {
        
        static let filmEntityName = "CDFilm"
    }
    
    enum Errors {
        
        static let filmsEmptyStateMessage = "No films... yet"
        static let filmsErrorStateMessage = "There was an error loading films"
    }
    
    enum Navigation {
        
        static let splashViewController = "SplashViewController"
        static let homeViewController = "HomeViewController"
        static let filmViewController = "FilmViewController"
        
        static let homeTableViewCell = "HomeTableViewCell"
    }
    
}

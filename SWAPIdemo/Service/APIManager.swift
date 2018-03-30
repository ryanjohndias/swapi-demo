//
//  APIManager.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

class APIManager {

    // MARK: - Singleton setup
    
    static let shared = APIManager()
    
    private init() {
        
    }
    
    // MARK: - Base url
    
    func baseURL() -> URL {
        
        guard let baseURL = URL(string: "https://swapi.co/api/") else {
            fatalError("baseURL is invalid")
        }
        
        return baseURL
    }
    
    // MARK: - API functions
    
    func getFilms(success: ((FilmsResponse) -> Void)?, failure: ((Error) -> Void)?) {
        
        var url = baseURL()
        url.appendPathComponent("films/")
        
        // Fetch all films
        NetworkManager.shared.get(url: url, success: { (response: FilmsResponse) in
            
            let group = DispatchGroup()
            
            var urls: [Int: String] = [:]
            
            // Fetch the OMDB record for each film
            for film in response.results {
                group.enter()
                self.searchOMDB(for: film.title, success: { (omdbFilm) in
                    urls[film.episodeId] = omdbFilm.Poster
                    group.leave()
                }, failure: { (error) in
                    group.leave()
                })
            }
            
            // All OMDB records have been fetched; continue with saving
            group.notify(queue: .main, execute: {
                for film in response.results {
                    CoreDataManager.shared.saveFilm(film: film, withImageUrl: urls[film.episodeId])
                }
                success?(response)
            })
            
        }, failure: failure)
    }
    
    func getPerson(withUrl urlString: String, success: ((Person) -> Void)?, failure: ((Error) -> Void)?) {
        
        let url = URL(string: urlString)
        if let url = url {
            NetworkManager.shared.get(url: url, success: success, failure: failure)
        } else {
            // TODO: Error handling
        }
    }
    
    func searchOMDB(for searchTerm: String, success: ((OMDBFilm) -> Void)?, failure: ((Error?) -> Void)?) {

        let searchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        let searchURLString = Constants.API.omdbSearchUrl.replacingOccurrences(of: "{searchTerm}", with: searchTerm)
        
        guard let searchUrl = URL(string: searchURLString) else {
            failure?(nil)
            return
        }

        NetworkManager.shared.get(url: searchUrl, success: { (searchResult: OMDBSearchResult) in
            
            // We're using a search API, so we have to assume the first result is the correct one
            if let film = searchResult.Search.first {
                
                let filmUrlString = Constants.API.omdbMovieUrl.replacingOccurrences(of: "{imdbId}", with: film.imdbId)
                
                if let filmUrl = URL(string: filmUrlString) {
                    NetworkManager.shared.get(url: filmUrl, success: success, failure: failure)
                } else {
                    failure?(nil)
                }
                
            } else {
                failure?(nil)
            }
            
        }) { (error) in
            failure?(nil)
        }

    }
    
}

//
//  CoreDataManager.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/30.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import UIKit

class CoreDataManager {
    
    // MARK: - Singleton setup
    
    static let shared = CoreDataManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var releaseDataFormatter = DateFormatter(withFormat: "YYYY-mm-dd")
    
    private init() {
        
    }
    
    // MARK: - functions
    
    func saveFilm(film: Film, withImageUrl imageUrl: String?) {
        
        let persistingFilm = CDFilm(entity: CDFilm.entity(), insertInto: context)
        persistingFilm.filmId = Int16(film.episodeId)
        persistingFilm.title = film.title
        persistingFilm.imageUrl = imageUrl
        persistingFilm.director = film.director
        persistingFilm.producer = film.producer
        if let releaseDate = releaseDataFormatter.date(from: film.releaseDate) as NSDate? {
            persistingFilm.releaseDate = releaseDate
        } else {
            print("Error parsing date when saving Film to Core Data")
        }
        
        appDelegate.saveContext()
    }
    
    func fetchFilms(success: ([CDFilm]) -> Void, failure: (NSError) -> Void) {
        do {
            let films = try context.fetch(CDFilm.fetchRequest()) as! [CDFilm]
            success(films)
        } catch let error as NSError {
            failure(error)
        }
    }
        
}

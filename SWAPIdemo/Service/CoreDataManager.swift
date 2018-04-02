//
//  CoreDataManager.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/30.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // MARK: - Singleton setup
    
    static let shared = CoreDataManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var releaseDateFormatter = DateFormatter(withFormat: "yyyy-MM-dd")
    var metaDataDateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ")

    private init() {
        
    }
    
    // MARK: - functions
    
    func saveFilm(film: Film, characters: [Person]?, withOMDBFilm omdbFilm: OMDBFilm?) {
        
        // Check if film exists
        fetchFilm(withId: film.episodeId, success: { (fetchedFilm) in
            
            if let existingFilm = fetchedFilm {
                
                // Test if the server film record has an edited date later than that of the local film record
                if let filmDateEdited = metaDataDateFormatter.date(from: film.dateEdited),
                    let existingFilmDate = existingFilm.dateEdited as Date? {
                    
                    if filmDateEdited.compare(existingFilmDate) == .orderedDescending {
                        updateFilm(existingFilm, with: film, withOMDBFilm: omdbFilm)
                    }
                }
                
            } else {
                insertFilm(film: film, characters: characters, withOMDBFilm: omdbFilm)
            }
            
        }) { (error) in
            insertFilm(film: film, characters: characters, withOMDBFilm: omdbFilm)
        }
    }
    
    func insertFilm(film: Film, characters: [Person]?, withOMDBFilm omdbFilm: OMDBFilm?) {
        
        let persistingFilm = CDFilm(entity: CDFilm.entity(), insertInto: context)
        persistingFilm.filmId = Int16(film.episodeId)
        persistingFilm.title = film.title
        persistingFilm.director = film.director
        persistingFilm.producer = film.producer
        persistingFilm.openingCrawlText = film.openingCrawlText
        
        if let omdbFilm = omdbFilm {
            persistingFilm.imageUrl = omdbFilm.Poster
            persistingFilm.rating = Double(omdbFilm.imdbRating) ?? 0
        }
        
        if let releaseDate = releaseDateFormatter.date(from: film.releaseDate) as NSDate? {
            persistingFilm.releaseDate = releaseDate
        } else {
            print("Error parsing release date when saving Film to Core Data")
        }
        
        if let dateCreated = metaDataDateFormatter.date(from: film.dateCreated) as NSDate? {
            persistingFilm.dateCreated = dateCreated
        } else {
            print("Error parsing dateCreated when saving Film to Core Data")
        }
        
        if let dateEdited = metaDataDateFormatter.date(from: film.dateEdited) as NSDate? {
            persistingFilm.dateEdited = dateEdited
        } else {
            print("Error parsing dateEdited when saving Film to Core Data")
        }
        
        // Characters
        if let characters = characters {
            for person in characters {
                let persistingCharacter = CDCharacter(entity: CDCharacter.entity(), insertInto: context)
                persistingCharacter.name = person.name
                
                persistingFilm.addToCharacters(persistingCharacter)
            }
        }
        
        appDelegate.saveContext()
    }
    
    func updateFilm(_ localFilm: CDFilm, with newFilm: Film, withOMDBFilm omdbFilm: OMDBFilm?) {
        
        localFilm.title = newFilm.title
        localFilm.director = newFilm.director
        localFilm.producer = newFilm.producer
        localFilm.openingCrawlText = newFilm.openingCrawlText
        
        if let omdbFilm = omdbFilm {
            localFilm.imageUrl = omdbFilm.Poster
            localFilm.rating = Double(omdbFilm.imdbRating) ?? 0
        }
        
        if let releaseDate = releaseDateFormatter.date(from: newFilm.releaseDate) as NSDate? {
            localFilm.releaseDate = releaseDate
        } else {
            print("Error parsing release date when saving Film to Core Data")
        }
        
        if let dateCreated = metaDataDateFormatter.date(from: newFilm.dateCreated) as NSDate? {
            localFilm.dateCreated = dateCreated
        } else {
            print("Error parsing dateCreated when saving Film to Core Data")
        }
        
        if let dateEdited = metaDataDateFormatter.date(from: newFilm.dateEdited) as NSDate? {
            localFilm.dateEdited = dateEdited
        } else {
            print("Error parsing dateEdited when saving Film to Core Data")
        }
        
        appDelegate.saveContext()
    }
    
    func fetchFilm(withId id: Int, success: (CDFilm?) -> Void, failure: (NSError) -> Void) {
        
        let filmFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData.filmEntityName)
        filmFetchRequest.predicate = NSPredicate(format: "filmId == %d", id)
        
        do {

            let fetchedFilms = try context.fetch(filmFetchRequest) as! [CDFilm]

            success(fetchedFilms.first)
        } catch let error as NSError {
            failure(error)
        }
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

//
//  FilmViewController.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var crawlingTextTextView: UITextView!
    
    // MARK: Class vars
    var film: CDFilm?
    var characters: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let film = film {
            titleLabel.text = film.title
//            releaseDateLabel.text = film.releaseDate
//            crawlingTextTextView.text = film.openingCrawlText
            
            // Creating a dispatch group for grouping the character async fetches
//            let group = DispatchGroup()
            
            // Fetching each character individually
//            for personUrlString in film.characters {
//                group.enter()
//                APIManager.shared.getPerson(withUrl: personUrlString, success: { (person) in
//                    self.characters.append(person)
//                    group.leave()
//                }, failure: { (error) in
//                    group.leave()
//                })
//            }
            
            // Group is completed - can now set the label
//            group.notify(queue: .main, execute: {
//                self.charactersLabel.text = self.characters.reduce("", { (result, person) in
//                    result == "" ? person.name : result + ", " + person.name
//                })
//
//                self.animateCrawl()
//            })
        }
        
        
        
        var transform = CATransform3DIdentity
        
        // Skew and rotate the text
        transform.m34 = -2.0 / 500.0
        transform = CATransform3DRotate(transform, CGFloat(45 * Double.pi / 180), 1, 0, 0)
        crawlingTextTextView.layer.transform = transform
    }
    
    func animateCrawl() {
        
        // FIXME: (needs tweaking)
        // Animate the scrolling
        
        let startOffset = CGPoint(x: 0, y: -200)
        let endOffset = CGPoint(x: 0, y: crawlingTextTextView.contentSize.height*2)
        
        crawlingTextTextView.setContentOffset(startOffset, animated: false)
        
        UIView.animate(withDuration: 10,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.crawlingTextTextView.setContentOffset(endOffset, animated: false)
        }, completion: nil)
    }

}
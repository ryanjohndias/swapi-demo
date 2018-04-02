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
    @IBOutlet weak var ratingLabel: UILabel!
    
    // MARK: Class vars
    var film: CDFilm?
    var characters: [Person] = []
    
    var releaseDateFormatter = DateFormatter(withFormat: "yyyy-MM-dd")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let film = film {
            titleLabel.text = film.title
            releaseDateLabel.text = releaseDateFormatter.string(for: film.releaseDate)
            ratingLabel.text = "\(film.rating)/10"
            crawlingTextTextView.text = film.openingCrawlText
            
            let charactersText = film.characters?.reduce("", { (result, character) in
                
                if let character = character as? CDCharacter,
                    let charactername = character.name,
                    let result = result {
                    return result == "" ? character.name : result + ", " + charactername
                } else {
                    return result
                }
                
            })
            
            charactersLabel.text = charactersText
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

//
//  ViewController.swift
//  CinematX
//
//  Created by Adam Londa on 23/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    var movieDb: MovieDatabaseWith<UIImage>?
    private var popularMovies: [MovieItem]?
    
    private let languageCode = NSLocalizedString("apiLanguageCode", comment: "API language code")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func signal(error: Error) {
        do {
            throw error
        } catch {
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDb!.getPopularMovies(languageCode: languageCode, completion: { result in
            switch result {
            case .Success(let movies):
                self.popularMovies = movies
            case .Failure(let e):
                self.signal(error: e)
            }
        })
    }
}


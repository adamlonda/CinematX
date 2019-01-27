//
//  ViewController.swift
//  CinematX
//
//  Created by Adam Londa on 23/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    var movieDb: MovieDatabaseProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let popularMovies = movieDb!.getPopularMovies()
    }
}


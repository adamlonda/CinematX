//
//  MovieDetailViewController.swift
//  CinematX
//
//  Created by Adam Londa on 09/02/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movieForDetail: Movie<UIImage>?
    
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImage.image = movieForDetail!.poster
        movieTitle.text = movieForDetail!.title
        movieOverview.text = movieForDetail!.overview
    }
}

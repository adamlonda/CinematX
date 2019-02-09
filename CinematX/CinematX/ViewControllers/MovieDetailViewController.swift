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
    @IBOutlet var genre: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var movieOverview: UILabel!
    
    private let dateFormatter: DateFormatter
    
    required init?(coder aDecoder: NSCoder) {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
        let localeId = NSLocalizedString("dateLocaleId", comment: "Date locale ID")
        dateFormatter.locale = Locale(identifier: localeId)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterImage.image = movieForDetail!.poster
        movieTitle.text = movieForDetail!.title
        genre.text = movieForDetail!.genres.joined(separator: ", ")
        movieOverview.text = movieForDetail!.overview
        releaseDate.text = dateFormatter.string(from: movieForDetail!.releaseDate)
    }
}

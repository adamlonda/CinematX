//
//  MovieDetailViewController.swift
//  CinematX
//
//  Created by Adam Londa on 09/02/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class MovieDetailViewController: ViewControllerBase {
    var movieDb: MovieDatabaseProtocol?
    var movieForDetail: MovieItemViewModel?
    
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
        
        guard let id = movieForDetail?.id else {
            fatalError("Should not happen.")
        }
        
        _ = self.movieDb?.getMovieDetail(id: id, with: languageCode).subscribe(
            onNext: { movieDetail in
                self.posterImage.image = self.movieForDetail?.poster
                self.movieTitle.text = self.movieForDetail?.title
        },
            onError: { error in
                self.showConnectionError()
        })
        
        
//        genre.text = movieForDetail?.genres.joined(separator: ", ")
//        movieOverview.text = movieForDetail?.overview
//
//        guard let movieReleaseDate = movieForDetail?.releaseDate else {
//            releaseDate.text = ""
//            return
//        }
        
//        releaseDate.text = dateFormatter.string(from: movieReleaseDate)
    }
}

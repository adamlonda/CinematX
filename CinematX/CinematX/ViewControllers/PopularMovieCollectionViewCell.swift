//
//  PopularMovieCollectionViewCell.swift
//  CinematX
//
//  Created by Adam Londa on 05/02/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class PopularMovieCollectionCell: UICollectionViewCell {
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var title: UILabel!
    
    var movie: MovieViewModel!
    
    func displayContent(from movie: MovieViewModel) {
        self.posterImage.image = movie.poster
        self.title.text = movie.title
        self.movie = movie
    }
}

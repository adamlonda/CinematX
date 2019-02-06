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
    
    func displayContent(posterImage: UIImage, title: String) {
        self.posterImage.image = posterImage
        self.title.text = title
    }
}

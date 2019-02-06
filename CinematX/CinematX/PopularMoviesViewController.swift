//
//  ViewController.swift
//  CinematX
//
//  Created by Adam Londa on 23/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    
    typealias ImageType = UIImage
    
    var movieDb: MovieDatabaseWith<ImageType>?
    
    private var popularMovies: [Movie<ImageType>]
    private let languageCode = NSLocalizedString("apiLanguageCode", comment: "API language code")
    
    required init?(coder aDecoder: NSCoder) {
        self.popularMovies = [Movie<ImageType>]()
        super.init(coder: aDecoder)
    }
    
    private func signal(error: Error) {
        print(error)
    }
    
    private func getMovies(from info: [MovieInfo]) {
        for i in info {
            self.movieDb!.getMovie(from: i)
                .subscribe(
                    onNext: { movie in
                        self.popularMovies.append(movie)
                        if self.popularMovies.count == info.count {
                            self.collectionView.reloadSections(IndexSet(integer: 0))
                        }
                },
                    onError: { e in
                        self.signal(error: e)
                })
        }
    }
    
    private func getPopularMovies() {
        popularMovies.removeAll()
        
        movieDb!.getPopularMoviesInfo(with: languageCode)
            .subscribe(
                onNext: { info in
                    self.getMovies(from: info)
            },
                onError: { e in
                    self.signal(error: e)
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularMovies()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularMovieCollectionViewCell", for: indexPath) as! PopularMovieCollectionCell
        let movie = popularMovies[indexPath.row]
        
        cell.displayContent(posterImage: movie.poster, title: movie.title)
        return cell
    }
}


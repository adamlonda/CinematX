//
//  ViewController.swift
//  CinematX
//
//  Created by Adam Londa on 23/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    typealias ImageType = UIImage
    
    @IBOutlet var collectionView: UICollectionView!
    
    var movieDb: MovieDatabaseWith<ImageType>?
    
    private var popularMovies: [Movie<ImageType>]
    private let languageCode = NSLocalizedString("apiLanguageCode", comment: "API language code")
    
    required init?(coder aDecoder: NSCoder) {
        self.popularMovies = [Movie<ImageType>]()
        super.init(coder: aDecoder)
    }
    
    private func alertConnectionError() {
        let alert = UIAlertController(
            title: NSLocalizedString("connectionError", comment: "Connection error title"),
            message: NSLocalizedString("connectionErrorMessage", comment: "Connection error message"),
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Try again", comment: "Try again label"), style: .default, handler: { action in
            self.getPopularMovies()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getMovies(from info: [MovieInfo]) {
        for i in info {
            self.movieDb!.getMovie(from: i)
                .subscribe(
                    onNext: { movie in
                        self.popularMovies.append(movie)
                        self.collectionView.reloadSections(IndexSet(integer: 0))
                },
                    onError: { e in
                        self.alertConnectionError()
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
                    self.alertConnectionError()
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
        cell.displayContent(from: movie)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let destination = (segue.destination as! MovieDetailViewController)
        destination.movieForDetail = (sender as! PopularMovieCollectionCell).movie
    }
}

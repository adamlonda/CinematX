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
//            self.getPopularMovies()
            fatalError()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
//    private func loadMovies(from info: [MovieInfo], with genreMap: [Int: String]) {
//        for i in info {
//            self.movieDb!.getMovie(from: i, with: genreMap)
//                .subscribe(
//                    onNext: { movie in
//                        self.popularMovies.append(movie)
//                        self.collectionView.reloadSections(IndexSet(integer: 0))
//                },
//                    onError: { _ in self.alertConnectionError() })
//        }
//    }
    
//    private func getMovieInfo(with genreMap: [Int: String]) {
//        movieDb!.getPopularMoviesInfo(with: languageCode)
//            .subscribe(
//                onNext: { info in self.loadMovies(from: info, with: genreMap) },
//                onError: { _ in self.alertConnectionError() })
//    }
    
//    private func getPopularMovies() {
//        popularMovies.removeAll()
//        movieDb!.getGenreMap(with: languageCode)
//        .subscribe(
//            onNext: { genreMap in self.getMovieInfo(with: genreMap) },
//            onError: { _ in self.alertConnectionError() }
//        )
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        getPopularMovies()
        fatalError()
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


//
//  ViewController.swift
//  CinematX
//
//  Created by Adam Londa on 23/01/2019.
//  Copyright © 2019 Adam Londa. All rights reserved.
//

import OfflineView
import RxSwift
import UIKit

class PopularMoviesViewController: ViewControllerBase, UICollectionViewDelegate, UICollectionViewDataSource {
    typealias ImageType = UIImage
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var offlineView: OfflineView!
    
    var movieDb: MovieDatabaseProtocol?
    
    private var popularMovies: [MovieItemViewModel]
    
    required init?(coder aDecoder: NSCoder) {
        self.popularMovies = [MovieItemViewModel]()
        super.init(coder: aDecoder)
    }
    
    override internal func showConnectionError() {
        collectionView.isHidden = true
        offlineView.isHidden = false
    }
    
    private func getPopularMovies() {
        if (movieDb?.isOnline() != true) {
            showConnectionError()
            return
        }
        
        collectionView.isHidden = false
        offlineView.isHidden = true
        
        popularMovies.removeAll()
        
        _ = movieDb?.getPopularMovies(with: languageCode).subscribe(
            onNext: { movie in
                self.popularMovies.append(movie)
                self.collectionView.reloadSections(IndexSet(integer: 0))
        },
            onError: { error in
                self.showConnectionError()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.offlineView.set(errorLabel: NSLocalizedString("connectionErrorMessage", comment: "Connection error message"))
        self.offlineView.set(tryAgainButtonLabel: NSLocalizedString("Try again", comment: "Try again label"))
        self.offlineView.set(tryAgainButtonSelector: self.getPopularMovies)
        
        guard  movieDb == nil else {
            getPopularMovies()
            return
        }
        
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


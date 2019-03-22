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

class PopularMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    typealias ImageType = UIImage
    
    @IBOutlet var collectionView: UICollectionView!
    
    var movieDb: MovieDatabaseWith<ImageType>?
    
    private var offlineView: OfflineView?
    private var popularMovies: [MovieViewModel<ImageType>]
    
    private let languageCode = NSLocalizedString("apiLanguageCode", comment: "API language code")
    
    required init?(coder aDecoder: NSCoder) {
        self.popularMovies = [MovieViewModel<ImageType>]()
        super.init(coder: aDecoder)
    }
    
    private func showConnectionError() {
        collectionView.isHidden = true
        
        guard offlineView == nil else {
            view.addSubview(offlineView!)
            return
        }
        
        fatalError()
    }
    
    private func getPopularMovies() {
        collectionView.isHidden = false
        offlineView?.removeFromSuperview()
        
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
        
        self.offlineView = OfflineView(frame: self.view.bounds)
        self.offlineView?.set(errorLabel: NSLocalizedString("connectionErrorMessage", comment: "Connection error message"))
        self.offlineView?.set(tryAgainButtonLabel: NSLocalizedString("Try again", comment: "Try again label"))
        self.offlineView?.set(tryAgainButtonSelector: self.getPopularMovies)
        // TODO: Add constraints programatically
        
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


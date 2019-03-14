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
    @IBOutlet var errorView: UIView!
    
    private var offlineView: OfflineView?
    
    var movieDb: MovieDatabaseWith<ImageType>?
    private var popularMovies: [MovieViewModel<ImageType>]
    
    private let languageCode = NSLocalizedString("apiLanguageCode", comment: "API language code")
    
    required init?(coder aDecoder: NSCoder) {
        self.popularMovies = [MovieViewModel<ImageType>]()
        super.init(coder: aDecoder)
    }
    
    private func showConnectionError() {
//        let alert = UIAlertController(
//            title: NSLocalizedString("connectionError", comment: "Connection error title"),
//            message: NSLocalizedString("connectionErrorMessage", comment: "Connection error message"),
//            preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Try again", comment: "Try again label"), style: .default, handler: { action in
//            self.getPopularMovies()
//        }))
//
//        self.present(alert, animated: true, completion: nil)
        
        collectionView.isHidden = true
        offlineView?.isHidden = false
//        errorView.isHidden = false
    }
    
//    private func presentOfflineView() {
//        fatalError()
//    }
    
    private func getPopularMovies() {
        errorView.isHidden = true
        offlineView?.set(isHidden: true)
        collectionView.isHidden = false
        
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
        
        guard  movieDb != nil else {
            handleUnexpectedError(
                title: "Dependency injection error",
                message: "This error should not happen, if Swinject registrations are set up properly. If you see this message, please fix dependency injections.")
            return
        }
        
        getPopularMovies()
    }
    
    @IBAction func onTryAgain(_ sender: UIButton) {
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


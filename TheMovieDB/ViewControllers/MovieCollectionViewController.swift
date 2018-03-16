//
//  MovieCollectionViewController.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

private let reuseIdentifier = "MovieCollectionViewCellIdentifier"

class MovieCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var moviesResponse: MoviesResponse?
    var moviesImages: [Int : UIImage] = [Int : UIImage]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
      
        self.loadMoviesWith(category: .popular)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - CLASS HELPERS
    private func loadMoviesWith(category: MovieRouter) {
        MovieFacade.getMovies(withCategory: category) { moviesResponse in
            self.moviesResponse = moviesResponse
            self.collectionView?.reloadData()
        }
    }

    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesResponse?.movies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            print("\(#function) Can't create cell with type MovieCollectionViewCell.")
            return UICollectionViewCell()
        }
    
        // Configure the cell
        guard let movie = moviesResponse?.movies?[indexPath.row] else {
            print("\(#function) Can't create movie with title.")
            return UICollectionViewCell()
        }

        let url = try? "https://image.tmdb.org/t/p/w154\(movie.posterPath ?? "")".asURL()
        
        cell.movieImage.af_setImage(withURL: url!)
        cell.movieTitle.text = movie.title
        
        return cell
    }
    
    // MARK: - IBACTIONS
    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            loadMoviesWith(category: .popular)
        case 1:
            loadMoviesWith(category: .upcoming)
        case 2:
            loadMoviesWith(category: .topRated)
        case 3:
            loadMoviesWith(category: .nowPlaying)
        default:
            break
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

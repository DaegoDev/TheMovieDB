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

class MovieCollectionViewController: UICollectionViewController {
    var moviesResponse: MoviesResponse?
    var moviesImages: [Int : UIImage] = [Int : UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        MovieFacade.nowPlaying { moviesResponse in
            self.moviesResponse = moviesResponse
            self.collectionView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesResponse?.movies?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            print("\(#function) Can't create cell with type MovieCollectionViewCell.")
            return UICollectionViewCell()
        }
    
        // Configure the cell
        guard let movie = moviesResponse?.movies?[indexPath.row] else {
            print("\(#function) Can't create movie with title.")
            return UICollectionViewCell()
        }
        
        Alamofire.request(
            "https://image.tmdb.org/t/p/w154\(movie.posterPath ?? "")"
            )
            .responseImage {response in
                guard let image = response.result.value else {
                    return
                }
                cell.movieImage.image = image
        }
        
        cell.movieTitle.text = movie.title
        return cell
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

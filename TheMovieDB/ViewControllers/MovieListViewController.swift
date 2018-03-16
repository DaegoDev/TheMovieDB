//
//  MovieListViewController.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, MovieListDelegate {
    
    @IBOutlet weak var contentView: UIView!
    var uiMovieList: MovieList?
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfCells() -> Int {
        return movies?.count ?? 0
    }
    
    func configureCell(cell: MovieListCell, index: Int) {
        cell.title.text = movies?[index].title
        let url = try? "https://image.tmdb.org/t/p/w154\(movies?[index].posterPath ?? "")".asURL()
        cell.poster.af_setImage(withURL: url!)
        
    }

    
    @IBAction func toggleListView(_ sender: UIButton) {
        
    }
    
    private func createTableView() {
        if uiMovieList != nil {
            (uiMovieList as! UIView).removeFromSuperview()
            uiMovieList = nil
        }
        
        uiMovieList = MovieListTableView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height))
        contentView.addSubview(uiMovieList as! UIView)
        uiMovieList?.movieListDelegate = self
    }
    
    private func createCollectionView() {
        if uiMovieList != nil {
            (uiMovieList as! UIView).removeFromSuperview()
            uiMovieList = nil
        }
        
        uiMovieList = MovieListCollectionView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height), collectionViewLayout: UICollectionViewFlowLayout())
        contentView.addSubview(uiMovieList as! UIView)
        uiMovieList?.movieListDelegate = self
    }
}

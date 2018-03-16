//
//  UIMovieListUITableView.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class MovieListTableView: UITableView, MovieList {

    var movieListDelegate: MovieListDelegate?
    fileprivate let rowHeitght = 90
    fileprivate let cellIdentifier = "MovieListTableCellIdentifier"
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func reloadAllData() {
        self.reloadData()
    }
}

extension MovieListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Setting \(self.movieListDelegate?.numberOfCells() ?? 0) rows")
        return self.movieListDelegate?.numberOfCells() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieListTableViewCell else {
            print("Error getting UIMovieListTableViewCell")
            return UITableViewCell()
        }
        
        movieListDelegate?.configureCell(cell: cell, index: indexPath.row)
        return cell
    }
}

extension MovieListTableView {
    func configure() {
        register(UINib(nibName: "MovieListTableCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        dataSource = self
        self.rowHeight = 150
    }
}












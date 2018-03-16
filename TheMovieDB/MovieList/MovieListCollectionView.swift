//
//  UIMovieListCollectionView.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class MovieListCollectionView: UICollectionView, MovieList {
    
    weak var movieListDelegate : MovieListDelegate?
    fileprivate let cellIdentifier = "ListCollectionViewCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let cellsPerRow = 2
    fileprivate let cellHeight: CGFloat = 300
    fileprivate let bottomSpaceBetweenCells: CGFloat = 10
    fileprivate let leftPadding: CGFloat = 10
    fileprivate let rightPadding: CGFloat = 10
    fileprivate let topPadding: CGFloat = 10
    fileprivate let middleSpaceBetweenCells: CGFloat = 10
    fileprivate let itemsPerRow: CGFloat = 2
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func reloadAllData(){
        reloadData()
    }
}

// MARK: - CollectionView Configuration
extension MovieListCollectionView {
    func configure() {
        dataSource = self
        delegate = self
        configureFlowLayout()
        self.register(UINib(nibName: "MovieListCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func configureFlowLayout() {
        let viewFlowLayout = UICollectionViewFlowLayout()
        
        
        viewFlowLayout.minimumInteritemSpacing = middleSpaceBetweenCells
        viewFlowLayout.minimumLineSpacing = bottomSpaceBetweenCells
        viewFlowLayout.sectionInset = UIEdgeInsetsMake(topPadding, leftPadding, 0, rightPadding)
        viewFlowLayout.scrollDirection = .vertical
        
        self.backgroundColor = UIColor.clear
        self.collectionViewLayout = viewFlowLayout
    }
}

// MARK: - CollectionViewDataSource
extension MovieListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieListDelegate?.numberOfCells() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath : IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieListCollectionViewCell else {
            print("Error getting UIMovieListTableViewCell")
            return UICollectionViewCell()
        }
        
        movieListDelegate?.configureCell(cell: cell as! MovieListCell, index: indexPath.row)
        return cell
    }
}

// MARK: - FlowLayout Delegate
extension MovieListCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        print("Inset for section")
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("Inset space")
        return sectionInsets.left
    }    
}








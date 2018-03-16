//
//  UIMovieListCell.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListCell: class {
    var title: UILabel! { get }
    var poster: UIImageView! { get }
}

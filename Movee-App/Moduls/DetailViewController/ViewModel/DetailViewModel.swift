//
//  DetailViewModel.swift
//  Movee-App
//
//  Created by Erol, Artun on 20.01.2022.
//

import Foundation
import UIKit

class DetailViewModel {
    var titleLabel: String
    var releaseDate: String
    var overView: String
    var posterImage: String

    init(titleLabel: String, releaseDate:String, overView:String, posterImage: String) {
        self.titleLabel = titleLabel
        self.releaseDate = releaseDate
        self.overView = overView
        self.posterImage = posterImage
    }
}

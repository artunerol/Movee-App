//
//  HorizontalCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 16.01.2022.
//

import UIKit
import Kingfisher

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePoster.backgroundColor = .clear
        moviePoster.layer.cornerRadius = 10
        moviePoster.contentMode = .scaleAspectFill
        // Initialization code
    }

    func configureCell(apiResult: PopularMoviesResultResponse, imageSize: ServiceURL) {
        guard let posterPath = apiResult.posterPath else { return }

        let imageURLString = StaticStringsList.imageBaseURL + imageSize.rawValue + posterPath
        let imageURL = URL(string: imageURLString)

        self.moviePoster.kf.setImage(with: imageURL)
    }
}

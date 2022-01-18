//
//  PopularMoviesCollectionViewCell.swift
//  Movee-App
//
//  Created by Artun Erol on 7.01.2022.
//

import UIKit
import Kingfisher

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK: - Public funcs
    
    func configureCell(apiResult: PopularMoviesResultResponse, imageSize: ServiceURL) { // conifugring the cell with response due to having multiple sections to configure
        configureCellContainerView()
        guard let title = apiResult.title else { return }
        guard let voteAverage = apiResult.voteAverage else { return }
        guard let releaseDate = apiResult.releaseDate else { return }
        guard let posterPath = apiResult.posterPath else { return }

        let imageURLString = StaticStringsList.imageBaseURL + imageSize.rawValue + posterPath
        let imageURL = URL(string: imageURLString)

        self.movieImage.kf.setImage(with: imageURL)
        self.movieTitle.text = title
        self.ratingLabel.text = String(voteAverage)
        self.releaseDate.text = releaseDate
    }
    //MARK: - Private Funcs
    
    private func configureCellContainerView() {
        configureSubLayers()
    }
    
    private func configureSubLayers() {
        cellContainerView.layer.masksToBounds = false
        cellContainerView.layer.cornerRadius = 10
    
        ratingContainerView.layer.cornerRadius = 10
        movieImage.layer.cornerRadius = 10
    }
}

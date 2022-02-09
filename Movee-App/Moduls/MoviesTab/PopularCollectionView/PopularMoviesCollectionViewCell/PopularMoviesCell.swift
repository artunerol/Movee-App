//
//  PopularMoviesCollectionViewCell.swift
//  Movee-App
//
//  Created by Artun Erol on 7.01.2022.
//

import UIKit
import Kingfisher

class PopularMoviesCell: UICollectionViewCell {
    @IBOutlet private weak var cellContainerView: UIView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var ratingContainerView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    // MARK: - Public funcs
    
    func configureCell(viewModel: PopularMovieCellViewModel) { // conifugring the cell with response due to having multiple sections to configure
        configureCellContainerView()
        guard let title = viewModel.apiResult.title else { return }
        guard let voteAverage = viewModel.apiResult.voteAverage else { return }
        guard let releaseDate = viewModel.apiResult.releaseDate else { return }
        guard let posterPath = viewModel.apiResult.posterPath else { return }

        let imageURLString = StaticStringsList.imageBaseURL + viewModel.imageSize.description + posterPath
        let imageURL = URL(string: imageURLString)

        self.movieImage.kf.setImage(with: imageURL)
        self.movieTitle.text = title
        self.ratingLabel.text = String(voteAverage)
        self.releaseDate.text = releaseDate
    }

    // MARK: - Private Funcs
    
    private func configureCellContainerView() {
        configureSubLayers()
    }
    
    private func configureSubLayers() {
        cellContainerView.layer.masksToBounds = false
        cellContainerView.layer.cornerRadius = 10
    
        ratingContainerView.layer.cornerRadius = 10
        movieImage.layer.cornerRadius = 8
    }
}

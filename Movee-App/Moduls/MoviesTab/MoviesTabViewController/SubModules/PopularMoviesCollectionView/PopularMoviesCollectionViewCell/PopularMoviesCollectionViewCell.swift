//
//  PopularMoviesCollectionViewCell.swift
//  Movee-App
//
//  Created by Artun Erol on 7.01.2022.
//

import UIKit

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK: - Public funcs
    
    func configureCell(apiResult: PopularMoviesResultResponse, posterImage: UIImage) { // conifugring the cell with response due to having multiple sections to configure
        configureCellContainerView()
        guard let title = apiResult.title else { return }
        guard let voteAverage = apiResult.voteAverage else { return }
        guard let releaseDate = apiResult.releaseDate else { return }
        
        self.movieImage.image = posterImage
        self.movieTitle.text = title
        self.ratingLabel.text = String(voteAverage)
        self.releaseDate.text = releaseDate
    }
    
    //MARK: - Private Funcs
    
    private func configureCellContainerView() {
        configureSubLayers()
    }
    
    private func configureSubLayers() {
        cellContainerView.layer.cornerRadius = 10
        ratingContainerView.layer.cornerRadius = 10
        movieImage.layer.cornerRadius = 10
    }
//
//    private func configureCellImage(imagePath: String?, imageSize: ServiceURL, posterImage: @escaping (UIImage?) -> Void) {
//        guard let imagePath = imagePath else { return }
//
//        let urlString = StaticStringsList.imageBaseURL + imageSize.rawValue + imagePath
//        guard let url = URL(string: urlString) else { return }
//
//        do {
//            let imageData = try Data(contentsOf: url)
//            let image = UIImage(data: imageData)
//            posterImage(image)
//        }
//        catch {
//            print("Cant Convert Image URL to Data")
//        }
//    }
}

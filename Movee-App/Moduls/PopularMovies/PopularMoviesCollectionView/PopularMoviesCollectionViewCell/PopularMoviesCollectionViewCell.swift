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
    
    //MARK: - Public funcs
    
    func configureCell(apiResult: PopulerMoviesResultResponse) { // conifugring the cell with response due to having multiple sections to configure
        configureCellContainerView()
        guard let title = apiResult.title else { return }
        guard let posterPath = apiResult.posterPath else { return }
        guard let voteAverage = apiResult.voteAverage else { return }
        
        configureCellImage(imagePath: posterPath) { [weak self] posterImage in
            guard let posterImage = posterImage else { return }
            self?.movieTitle.text = title
            self?.movieImage.image = posterImage
        }
    }
    
    //MARK: - Private Funcs
    
    private func configureCellContainerView() {
        cellContainerView.layer.cornerRadius = 10
        
        movieTitle.numberOfLines = 0
    }
    //MARK: - Configure Cell Image
    
    private func configureCellImage(imagePath: String?, posterImage: @escaping (UIImage?) -> Void) {
        guard let imagePath = imagePath else { return }
        
        let urlString = StaticStringsList.imageBaseURL + StaticStringsList.popularMoviesW500Poster + imagePath
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        
        do {
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
            posterImage(image)
        }
        catch {
            print("Cant Convert Image URL to Data")
        }
    }
}

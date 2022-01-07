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
    
    //MARK: - Public funcs
    
    func configureCell(title: String) {
        configureCellContainerView()
        guard let movieTitle = movieTitle else { return }
        movieTitle.text = title
    }
    
    //MARK: - Public Funcs
    
    private func configureCellContainerView() {
        cellContainerView.layer.cornerRadius = 10
    }
}

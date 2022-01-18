//
//  HorizontalCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 16.01.2022.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePoster.backgroundColor = .clear
        moviePoster.layer.cornerRadius = 10
        moviePoster.contentMode = .scaleAspectFill
        // Initialization code
    }
    
    func configureCell(posterImage: UIImage) {
        moviePoster.image = posterImage
    }
}

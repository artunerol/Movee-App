//
//  CastCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 21.01.2022.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var castImage: UIImageView!
    @IBOutlet private weak var castName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        castImageRound()
        // Initialization code
    }

    func configure(item: CastResultResponse) {
        guard let name = item.name else { return }
        if let imagePath = item.profilePath { // Eğer resmi yoksa default bir profil resmi koy
            let urlString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + imagePath
            let castImageURL = URL(string: urlString)
            self.castImage.kf.setImage(with: castImageURL)
        }

        self.castName.text = name
    }

    private func castImageRound() {
        castImage.layer.cornerRadius = 10
        castImage.contentMode = .scaleAspectFill
        castImage.clipsToBounds = true
    }
}

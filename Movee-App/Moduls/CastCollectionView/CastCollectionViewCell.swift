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
        // Initialization code
    }

    func configure(item: CastResultResponse) {
        guard let name = item.name else { return }
        if let imagePath = item.profilePath { // Eğer resmi yoksa default bir profil resmi koy
            let urlString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + imagePath
            let castImageURL = URL(string: urlString)
            let processor = RoundCornerImageProcessor(cornerRadius: (castImage.frame.height) / 2)
            castImage.kf.setImage(with: castImageURL, options: [.processor(processor)])
            self.castName.text = name
        }
    }
}

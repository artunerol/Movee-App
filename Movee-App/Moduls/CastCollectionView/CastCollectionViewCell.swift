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
        if let imagePath = item.profilePath, let name = item.name { // Eğer resmi yoksa default bir profil resmi koy
            let urlString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + imagePath
            let castImageURL = URL(string: urlString)
            castImage.layer.cornerRadius = castImage.frame.height / 2
            castImage.kf.setImage(with: castImageURL)
            self.castName.text = name
        } else {
            castImage.image = UIImage(systemName: "person.fill")
            castImage.tintColor = .blue
            castName.text = "Cast_Name Unavailable"
        }
    }
}

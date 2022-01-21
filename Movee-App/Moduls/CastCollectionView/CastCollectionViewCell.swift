//
//  CastCollectionViewCell.swift
//  Movee-App
//
//  Created by Erol, Artun on 21.01.2022.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        castImageRound()
        // Initialization code
    }

    func configure(item: CastResultResponse) {
        guard let name = item.name else { return }
        guard let imagePath = item.profilePath else { return }

        let urlString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + imagePath
        let castImageURL = URL(string: urlString)
        print("url is \(urlString)")
        self.castName.text = name
        self.castImage.kf.setImage(with: castImageURL)
    }

    private func castImageRound() {
        castImage.layer.cornerRadius = 10
        castImage.contentMode = .scaleAspectFill
        castImage.clipsToBounds = true
    }

}

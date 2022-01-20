//
//  DetailViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 20.01.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var ratingContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var overView: UILabel!
    @IBOutlet private weak var castCollectionView: UICollectionView!

    //MARK: -
    var viewModel: DetailViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewConfigurations()
    }

    private func setupView() {
        ratingContainerView.layer.cornerRadius = 10
    }

    private func setupViewConfigurations() {
        guard let viewModel = viewModel else { return }

        let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.rawValue + viewModel.posterImage
        guard let imageURL = URL(string: imageURLString) else { return }

        posterImage.kf.setImage(with: imageURL)
        titleLabel.text = viewModel.titleLabel
        releaseDate.text = viewModel.releaseDate
        overView.text = viewModel.overView
    }
}

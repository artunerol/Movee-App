//
//  DetailViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 20.01.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var ratingContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var overView: UILabel!
    @IBOutlet private weak var castCollectionView: UICollectionView!
    @IBOutlet private weak var seasonsContainerView: UIView!
    @IBOutlet private weak var seasonsLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!

    // MARK: -
    var viewModel: TVDetailViewModel?
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Funcs

    private func setupView() {
        ratingContainerView.layer.cornerRadius = 12
        seasonsContainerView.layer.cornerRadius = 12
        setupCollectionView()
    }

    private func setupViewConfigurations() {
        guard let viewModel = viewModel else { return }

        let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + viewModel.model.posterImage
        guard let imageURL = URL(string: imageURLString) else { return }

        posterImage.kf.setImage(with: imageURL)
        titleLabel.text = viewModel.model.titleLabel
        releaseDate.text = viewModel.model.releaseDate
        overView.text = viewModel.model.overView
        seasonsLabel.text = viewModel.tvDetailResult?.numberOfSeasons?.string() ?? "5" + " seasons"
        durationLabel.text = viewModel.tvDetailResult?.episodeRunTime?[0].string() ?? "15" + " mins"
    }

    private func setupCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        registerCollectionView()
        reloadCollectionViewData()
    }

    private func registerCollectionView() {
        castCollectionView.register(UINib(nibName: CastCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: CastCollectionViewCell.nameOfClass)
    }

    private func reloadCollectionViewData() {
        viewModel?.castResultSuccess = { [weak self] in
            self?.setupViewConfigurations()
            self?.castCollectionView.reloadData()
        }
    }
}

// MARK: - Extension
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.castResultArray.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModel?.castResultArray[indexPath.row],
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CastCollectionViewCell.nameOfClass,
                for: indexPath
              )
                as? CastCollectionViewCell
        else { return UICollectionViewCell() }

        cell.configure(item: item)

        return cell
    }
}

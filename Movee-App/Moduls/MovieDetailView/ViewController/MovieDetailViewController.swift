//
//  MovieDetailViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 24.01.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var ratingContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var overView: UILabel!
    @IBOutlet private weak var castCollectionView: UICollectionView!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var productionCompanyLabel: UILabel!
    // MARK: -
    var viewModel: MovieDetailViewModel?
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Funcs

    private func setupView() {
        ratingContainerView.layer.cornerRadius = 12
        setupCollectionView()
    }

    private func setupViewConfigurations() {
        setMovieDetail()
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

    private func setMovieDetail() {
        viewModel?.movieDetailSuccess = { [weak self] in
            guard let self = self,
                  let viewModel = self.viewModel,
                  let movieDetailResult = viewModel.movieDetailResult
            else { return }

            let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + viewModel.model.posterImage
            guard let imageURL = URL(string: imageURLString) else { return }

            self.posterImage.kf.setImage(with: imageURL)
            self.titleLabel.text = viewModel.model.titleLabel
            self.releaseDate.text = viewModel.model.releaseDate
            self.overView.text = viewModel.model.overView
            self.ratingLabel.text = viewModel.model.rating
            self.durationLabel.text = (movieDetailResult.runtime ?? 0).string() + " mins"
            self.productionCompanyLabel.text = movieDetailResult.productionCompanies?[0].name
        }
    }
}
// MARK: - Extension
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

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
        viewModel?.prepareCastData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Private Funcs

    private func setupView() {
        ratingContainerView.layer.cornerRadius = 12
        setupCollectionView()
        setupViewBindings()
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
            self?.castCollectionView.reloadData()
        }
    }

    private func setupViewBindings() {
        viewModel?.movieDetailSuccess = { [weak self] in
            guard let self = self,
                  let viewModel = self.viewModel,
                  let movieDetailResult = viewModel.movieDetailResult
            else { return }

            let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.w500Poster.description + viewModel.model.posterImage
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
    // MARK: - CollectionView
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
        cell.backgroundColor = .cyan

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 200)
    }
    // MARK: - Cell SELECTED
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModel?.castResultArray[indexPath.row] else { return }
        let viewModel = PersonDetailViewModel(id: item.id ?? 0)
        let viewController = PersonDetailViewController(nibName: PersonDetailViewController.nameOfClass, bundle: nil)
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
}

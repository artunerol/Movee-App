//
//  DetailViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 20.01.2022.
//

import UIKit
import Kingfisher

class TVDetailViewController: UIViewController {
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
    @IBOutlet private weak var creatorsLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!

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
        setTVDetail()
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

    private func setTVDetail() {
        viewModel?.tvDetailSuccess = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self,
                      let viewModel = self.viewModel
                else { return }

                let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + viewModel.model.posterImage
                guard let imageURL = URL(string: imageURLString) else { return }

                print("setTVDetail Success")
                self.posterImage.kf.setImage(with: imageURL)
                self.ratingLabel.text = viewModel.model.rating
                self.titleLabel.text = viewModel.model.titleLabel
                self.releaseDate.text = viewModel.model.releaseDate
                self.overView.text = viewModel.model.overView
                self.seasonsLabel.text = (viewModel.tvDetailResult?.numberOfSeasons?.string() ?? "Unavailable") + " seasons"
                self.durationLabel.text = (viewModel.tvDetailResult?.episodeRunTime?[0].string() ?? "Unavailable") + " mins"
                self.creatorsLabel.text = viewModel.tvDetailResult?.createdBy?.reduce("") { $0 + (($1.name ?? "Creator Unavailable") + ", ") }
            }
        }
    }
}

// MARK: - Extension
extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

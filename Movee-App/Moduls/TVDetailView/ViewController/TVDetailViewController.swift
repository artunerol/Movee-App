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
        viewModel?.prepareData()
        setupView()
    }
    // MARK: - Private Funcs

    private func setupView() {
        ratingContainerView.layer.cornerRadius = 12
        seasonsContainerView.layer.cornerRadius = 12
        setupCollectionView()
        setupViewConfigurations()
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
            self?.castCollectionView.reloadData()
        }
    }

    private func setTVDetail() {
        viewModel?.tvDetailSuccess = { [weak self] in
            guard let viewModel = self?.viewModel
            else { return }

            let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.w500Poster.description + viewModel.model.posterImage
            guard let imageURL = URL(string: imageURLString) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.posterImage.kf.setImage(with: imageURL)
                self?.ratingLabel.text = viewModel.model.rating
                self?.titleLabel.text = viewModel.model.titleLabel
                self?.releaseDate.text = viewModel.model.releaseDate
                self?.overView.text = viewModel.model.overView
                self?.seasonsLabel.text = (viewModel.tvDetailResult?.numberOfSeasons?.string() ?? "Unavailable") + " seasons"
                self?.durationLabel.text = (viewModel.tvDetailResult?.episodeRunTime?[0].string() ?? "Unavailable") + " mins"
                self?.creatorsLabel.text = viewModel.tvDetailResult?.createdBy?.reduce("") { $0 + (($1.name ?? "Creator Unavailable") + ", ") }
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 150)
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

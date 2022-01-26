//
//  TVSeriesMainTabViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 19.01.2022.
//

import UIKit

class TVSeriesMainTabViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var horizontalCollectionView: UICollectionView!
    @IBOutlet private weak var topRatedCollectionView: UICollectionView!

    // MARK: - Public Properties
    var viewModel: TVSeriesViewModel?

    // MARK: - Private Properties
    private var apiResult: [TopRatedResultResponse] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAPI()
        setupCollectionView()

        viewModel?.preparePopularTVSeries()
    }
    // MARK: - Private func

    private func handleAPI() {
        viewModel?.popularTVSeriesSuccessClosure = { [weak self] result in
            self?.apiResult = result
            self?.horizontalCollectionView.reloadData()
            self?.topRatedCollectionView.reloadData()
        }
        viewModel?.popularTVSeriesFailedClosure = { error in
            print("error is \(error)")
        }
    }

    private func setupCollectionView() {
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self

        horizontalCollectionView.backgroundColor = .clear
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        topRatedCollectionView.showsVerticalScrollIndicator = false

        registerCellToCollectionView()
    }

    private func registerCellToCollectionView() {
        topRatedCollectionView.register(
            UINib(
                nibName: TVSeriesTopRatedCollectionViewCell.nameOfClass,
                bundle: nil
            ),
            forCellWithReuseIdentifier: TVSeriesTopRatedCollectionViewCell.nameOfClass
        )
        horizontalCollectionView.register(
            UINib(
                nibName: HorizontalCollectionViewCell.nameOfClass,
                bundle: nil
            ),
            forCellWithReuseIdentifier: HorizontalCollectionViewCell.nameOfClass
        )
    }
}

// MARK: - Extensions

extension TVSeriesMainTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        apiResult.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }

        if collectionView == topRatedCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TVSeriesTopRatedCollectionViewCell.nameOfClass,
                for: indexPath
            ) as? TVSeriesTopRatedCollectionViewCell
            else { return UICollectionViewCell() }
            // Cell Configure Below
            cell.configureCell(apiResult: viewModel.tvSeriesResultArray[indexPath.row], imageSize: .popularMoviesW500Poster)

            return cell
        }

        if collectionView == horizontalCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HorizontalCollectionViewCell.nameOfClass,
                for: indexPath
            ) as? HorizontalCollectionViewCell
            else { return UICollectionViewCell() }

            let item = viewModel.tvSeriesResultArray[indexPath.row]
            let model = CollectionViewCellDataModel(
                posterPath: item.posterPath ?? "",
                title: item.name ?? "",
                rating: item.voteAverage ?? 0
            )

            cell.configureCell(model: model)

            return cell
        }
        return UICollectionViewCell()
    }

    // MARK: - Cell Pressed

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = apiResult[indexPath.row]
        let detailModel = DetailModel(
            titleLabel: item.name ?? "",
            releaseDate: item.firstAirDate ?? "",
            overView: item.overview ?? "",
            posterImage: item.posterPath ?? "",
            id: item.id ?? 0,
            rating: String((item.voteAverage ?? 0))
        )

        let viewModel = TVDetailViewModel(model: detailModel)
        viewModel.prepareData(castType: .tvSeries)
        let viewController = TVDetailViewController(nibName: TVDetailViewController.nameOfClass, bundle: nil)
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Cell Layout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topRatedCollectionView {
            let width: CGFloat = ((collectionView.frame.size.width) - 22) / 2
            let height: CGFloat = 310
            return CGSize(width: width, height: height)
        }

        if collectionView == horizontalCollectionView {
            return CGSize(width: 294, height: 484)
        }
        return .zero
    }
}

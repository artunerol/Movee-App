//
//  TVSeriesMainTabViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 19.01.2022.
//

import UIKit

class TVSeriesMainTabViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var horizontalCollectionView: UICollectionView!
    @IBOutlet private weak var topRatedCollectionView: UICollectionView!

    //MARK: - Public Properties
    var viewModel: TVSeriesViewModel? = nil

    //MARK: - Private Properties
    private var apiResult: [TopRatedResultResponse] = []

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAPI()
        setupCollectionView()

        viewModel?.preparePopularTVSeries()
    }
    //MARK: - Private func

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
        topRatedCollectionView.register(UINib(nibName: TVSeriesTopRatedCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: TVSeriesTopRatedCollectionViewCell.nameOfClass)
        horizontalCollectionView.register(UINib(nibName: HorizontalCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: HorizontalCollectionViewCell.nameOfClass)
    }
}

//MARK: - Extensions

extension TVSeriesMainTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiResult.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }

        if collectionView == topRatedCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeriesTopRatedCollectionViewCell.nameOfClass, for: indexPath) as? TVSeriesTopRatedCollectionViewCell else { return UICollectionViewCell() }
            //Cell Configure Below
            cell.configureCell(apiResult: viewModel.tvSeriesResultArray[indexPath.row], imageSize: .popularMoviesW500Poster)

            return cell
        }

        if collectionView == horizontalCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.nameOfClass, for: indexPath) as? HorizontalCollectionViewCell else { return UICollectionViewCell() }

            let item = viewModel.tvSeriesResultArray[indexPath.row]
            let model = HorizontalCollectionViewCellUIModel(
                posterPath: item.posterPath ?? "",
                title: item.name ?? "",
                rating: item.voteAverage ?? 0)

            cell.configureCell(model: model)

            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topRatedCollectionView {
            let width: CGFloat = ((collectionView.frame.size.width)/2 - 20)
            let height: CGFloat = (collectionView.frame.size.height) - 40
            return CGSize(width: width, height: height)
        }

        if collectionView == horizontalCollectionView {
            return CGSize(width: 260, height: collectionView.frame.height)
        }
        return CGSize(width: 0, height: 0)
    }
}

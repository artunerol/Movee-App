//
//  MoviesTabMainViewController.swift
//  Movee-App
//
//  Created by Ismail Kilic on 7.01.2022.
//

import UIKit
import Kingfisher

class MoviesTabMainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet private weak var horizontolCollectionView: UICollectionView!
    // MARK: - Public Properties
    var viewModel: MoviesTabMainViewModel?
    // MARK: - Private Properties
    private var apiResult: [PopularMoviesAPIResultResponse] = []
    // MARK: - Lifce Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAPIResult()
        
        setupCollectionView()
        viewModel?.preparePopulerMovies()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - API Result Handling
    private func handleAPIResult() {
        viewModel?.populerMoviesSuccessClosure = { [weak self] result in
            self?.apiResult = result
            self?.popularMoviesCollectionView.reloadData()
            self?.horizontolCollectionView.reloadData()
        }
        
        viewModel?.populerMoviesFailedClosure = { [weak self] errorMessage in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Hata", message: errorMessage, preferredStyle: .actionSheet)
            alert.show(self, sender: nil)
        }
    }
    // MARK: - Private func
    
    private func setupCollectionView() {
        popularMoviesCollectionView.delegate = self
        popularMoviesCollectionView.dataSource = self
        horizontolCollectionView.delegate = self
        horizontolCollectionView.dataSource = self
        
        horizontolCollectionView.backgroundColor = .clear
        horizontolCollectionView.showsHorizontalScrollIndicator = false
        popularMoviesCollectionView.showsVerticalScrollIndicator = false
    
        registerCellToCollectionView()
    }

    private func registerCellToCollectionView() {
        popularMoviesCollectionView.register(
            UINib(
                nibName: PopularMoviesCollectionViewCell.nameOfClass,
                bundle: nil
            ),
            forCellWithReuseIdentifier: PopularMoviesCollectionViewCell.nameOfClass
        )
        horizontolCollectionView.register(
            UINib(
                nibName: HorizontalCollectionViewCell.nameOfClass,
                bundle: nil
            ),
            forCellWithReuseIdentifier: HorizontalCollectionViewCell.nameOfClass
        )
    }
}

// MARK: - Extensions
extension MoviesTabMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        if collectionView == popularMoviesCollectionView {
            return viewModel.movieResultArray.count
        }
        
        if collectionView == horizontolCollectionView {
            return viewModel.movieResultArray.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        
        if collectionView == popularMoviesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularMoviesCollectionViewCell.nameOfClass,
                for: indexPath
            ) as? PopularMoviesCollectionViewCell
            else { return UICollectionViewCell() }
            // Cell Configure Below
            cell.configureCell(apiResult: viewModel.movieResultArray[indexPath.row], imageSize: .popularMoviesW500Poster)
            
            return cell
        }
        
        if collectionView == horizontolCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HorizontalCollectionViewCell.nameOfClass,
                for: indexPath
            ) as? HorizontalCollectionViewCell
            else { return UICollectionViewCell() }

            let item = viewModel.movieResultArray[indexPath.row]
            let model = CollectionViewCellDataModel(
                posterPath: item.posterPath ?? "",
                title: item.title ?? "",
                rating: item.voteAverage ?? 0
            )

            cell.configureCell(model: model)
            
            return cell
        }
        return UICollectionViewCell()
    }

    // MARK: - Cell DidSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = apiResult[indexPath.row]
        let detailModel = DetailModel(
            titleLabel: item.title ?? "",
            releaseDate: item.releaseDate ?? "",
            overView: item.overview ?? "",
            posterImage: item.posterPath ?? "",
            id: item.id ?? 0,
            rating: String((item.voteAverage ?? 0))
        )
        let viewModel = MovieDetailViewModel(model: detailModel)
        let viewController = MovieDetailViewController(nibName: MovieDetailViewController.nameOfClass, bundle: nil)
        viewController.viewModel = viewModel

        navigationController?.pushViewController(viewController, animated: true)
    }
    // MARK: - FloywLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == popularMoviesCollectionView {
            let size: CGFloat = (collectionView.frame.size.width)
            return CGSize(width: size, height: 100)
        }
        
        if collectionView == horizontolCollectionView {
            return CGSize(width: 260, height: collectionView.frame.height)
        }
        return CGSize(width: 0, height: 0)
    }
}

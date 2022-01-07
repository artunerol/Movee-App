//
//  PopularMoviesViewController.swift
//  Movee-App
//
//  Created by Ismail Kilic on 7.01.2022.
//

import UIKit

class PopularMoviesViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private weak var PopularMoviesCollectionView: UICollectionView!

    //MARK: - Properties

    var viewModel: PopularMoviesViewModel? = nil

    //MARK: - Lifce Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()

        setupCollectionView()
        viewModel?.preparePopuperMovies()
    }

    //    //MARK: - Bindings
    func setupBindings() {
        viewModel?.populerMoviesSuccessClosure = { [weak self] _ in
            self?.PopularMoviesCollectionView.reloadData()
        }

        viewModel?.populerMoviesFailedClosure = { [weak self] errorMessage in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Hata", message: errorMessage, preferredStyle: .actionSheet)
            alert.show(self, sender: nil)
        }
    }

    //MARK: - Private func

    private func setupCollectionView() {
        PopularMoviesCollectionView.delegate = self
        PopularMoviesCollectionView.dataSource = self
        addHeaderToCollectionView()
        addCellToCollectionView()
    }

    private func addHeaderToCollectionView() {
        PopularMoviesCollectionView.register(
            PopularMoviesHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StaticStringsList.popularMoviesReusableHeader)
    }

    private func addCellToCollectionView() {
        PopularMoviesCollectionView.register(PopularMoviesCollectionViewCell.self, forCellWithReuseIdentifier: PopularMoviesCollectionViewCell.nameOfClass)
    }
}

//MARK: - Extensions
extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.movieResultArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesCollectionViewCell.nameOfClass, for: indexPath) as? PopularMoviesCollectionViewCell else { return UICollectionViewCell() }
        //Cell Configure Below

        if let title = viewModel.movieResultArray[indexPath.row].title {
            cell.configureCell(title: title)
        }

        return cell
    }

    //MARK: - Header

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StaticStringsList.popularMoviesReusableHeader, for: indexPath)
        //        header.backgroundColor = .blue //Header ile ilgili renk vs UI configurationları kod yazarak yapıyorsak storyboardda header'ı renkli yapmam ne işe yarıyor?

        return header
    }
}

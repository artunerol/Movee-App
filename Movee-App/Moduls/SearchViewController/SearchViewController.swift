//
//  SearchViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 7.02.2022.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet private weak var moveeSearchBar: UISearchBar!
    @IBOutlet private weak var searchResultCollectionView: UICollectionView!
    @IBOutlet private weak var emptyView: EmptyView!

    // MARK: - Public Properties
    var viewModel: SearchViewModel?

    // MARK: - Private Properties
    var apiResultArray: [SearchResultAPIResponse]?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - Private funcs

    private func setupViews() {
        setupCollectionView()
        setupSearchBar()
        emptyView.isHidden = true
    }

    private func setupCollectionView() {
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.register(
            UINib(
                nibName: SearchCollectionViewCell.nameOfClass,
                bundle: nil
            ),
            forCellWithReuseIdentifier: SearchCollectionViewCell.nameOfClass
        )
        searchResultCollectionView.showsVerticalScrollIndicator = false
    }

    private func setupSearchBar() {
        moveeSearchBar.delegate = self
        moveeSearchBar.moveeSearchBar()
    }
}

// MARK: - CollectionView Extension

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        apiResultArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCollectionViewCell.nameOfClass,
            for: indexPath
        ) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        let configureModel = viewModel.searchResultArray[indexPath.row]
        viewModel.fetchSubData(id: configureModel.id ?? 0, type: configureModel.mediaType ?? MediaType.defaultType)

        cell.configureCell(for: configureModel)
        //cell.configureCell(for: viewModel.castResultArray[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 48, height: 100)
    }
}
// MARK: - SearchBar Extension

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let viewModel = viewModel else { return }
        if !searchText.isEmpty {
            viewModel.search(keyword: searchText)
            viewModel.searchSuccessClosure = { [weak self] result in
                if !result.isEmpty {
                    self?.emptyView.isHidden = true
                    self?.searchResultCollectionView.isHidden = false
                    self?.apiResultArray = result
                    self?.searchResultCollectionView.reloadData()
                } else {
                    self?.emptyView.isHidden = false
                    self?.searchResultCollectionView.isHidden = true
                }
            }
        } else {
            apiResultArray?.removeAll()
            searchResultCollectionView.reloadData()
        }
    }
}

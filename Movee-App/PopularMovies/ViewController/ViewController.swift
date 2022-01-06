//
//  ViewController.swift
//  Movee-App
//
//  Created by Artun Erol on 5.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var PopularMoviesCollectionView: UICollectionView!
        
    //MARK: - Properties
    
    private let networkManager = NetworkManager()
    
    //MARK: - Lifce Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        networkManager.fetchData(as: APIData.self)
    }
    
    //MARK: - Private func
    
    private func setupCollectionView() {
        PopularMoviesCollectionView.delegate = self
        PopularMoviesCollectionView.dataSource = self
        addHeaderToCollectionView()
        addCellToCollectionView()
    }
    
    private func addHeaderToCollectionView() {
        PopularMoviesCollectionView.register(PopularMoviesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StaticStringsList.popularMoviesReusableHeader)
    }
    
    private func addCellToCollectionView() {
        PopularMoviesCollectionView.register(PopularMoviesCollectionViewCell.self, forCellWithReuseIdentifier: StaticStringsList.popularMoviesCollectionViewCellIdentifier)
    }
    
}

//MARK: - Extensions

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticStringsList.popularMoviesCollectionViewCellIdentifier, for: indexPath) as? PopularMoviesCollectionViewCell else { return UICollectionViewCell() }
        //Cell Configure Below
        
        return cell
    }
    
    //MARK: - Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StaticStringsList.popularMoviesReusableHeader, for: indexPath)
        header.backgroundColor = .blue //Header ile ilgili renk vs UI configurationları kod yazarak yapıyorsak storyboardda header'ı renkli yapmam ne işe yarıyor?
        header.frame.size.height = 100
        
        return header
    }
}



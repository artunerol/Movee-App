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
    
    var viewModel: ViewControllerViewModel? = nil
    
    //MARK: - Lifce Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        apiDataObserver()
    }
    
//    //MARK: - Init
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: StaticStringsList.apiDataObserver), object: nil)
    }
//
//    init(with viewModel: ViewControllerViewModel) { //Init bu şekilde yapılsa, aşağıdaki gibi designated init yeterli olur mu yoksa designated init'i override ederek mi çağırmak gerekir? Bu yapıyı dependency injection yapıp viewModel'i çağırabilmek için kuruyorum.
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }


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
    
    //MARK: - Observer
    
    private func apiDataObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(apiDataReceived), name: .apiDataObserver(), object: nil)
    }
    
    @objc private func apiDataReceived() {
        self.PopularMoviesCollectionView.reloadData()
    }
    
}

//MARK: - Extensions

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.movieResultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticStringsList.popularMoviesCollectionViewCellIdentifier, for: indexPath) as? PopularMoviesCollectionViewCell else { return UICollectionViewCell() }
        //Cell Configure Below
        cell.configureCell(with: viewModel.movieResultArray[indexPath.row])
        
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



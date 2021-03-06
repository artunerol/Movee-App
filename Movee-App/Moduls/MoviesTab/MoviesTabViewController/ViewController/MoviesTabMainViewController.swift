//
//  MoviesTabMainViewController.swift
//  Movee-App
//
//  Created by Ismail Kilic on 7.01.2022.
//

import UIKit

class MoviesTabMainViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var horizontolCollectionView: UICollectionView!
    
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var moviePosterMainLabel: UILabel!
    //MARK: - Public Properties
    var viewModel: MoviesTabMainViewModel? = nil
    
    //MARK: - Private Properties
    private var apiResult: [PopularMoviesResultResponse] = []
    private var apiPosterImagesArray: [UIImage] = []
    
    //MARK: - Lifce Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAPIResult()
        
        setupCollectionView()
        setupCustomViews()
        viewModel?.preparePopulerMovies()
    }
    //MARK: - API Result Handling
    private func handleAPIResult() {
        viewModel?.populerMoviesSuccessClosure = { [weak self] result in
            self?.apiResult = result
            self?.handleCellImageConvertingToData(imagePath: result, imageSize: .popularMoviesW500Poster)
            
            self?.popularMoviesCollectionView.reloadData()
            self?.horizontolCollectionView.reloadData()
        }
        
        viewModel?.populerMoviesFailedClosure = { [weak self] errorMessage in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Hata", message: errorMessage, preferredStyle: .actionSheet)
            alert.show(self, sender: nil)
        }
    }
    //MARK: - Converting Image String to UIImage
    
    private func handleCellImageConvertingToData(imagePath: [PopularMoviesResultResponse], imageSize: ServiceURL) {
        let imageStringPathArray = imagePath.compactMap { $0.posterPath }
        
        for imageStringPath in imageStringPathArray {
            let urlString = StaticStringsList.imageBaseURL + imageSize.rawValue + imageStringPath
            
            guard let url = URL(string: urlString) else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                self.apiPosterImagesArray.append(image)
            }
            catch {
                print("Cant Convert imageURLString to UIImage")
            }
        }
    }
    //MARK: - Private func
    
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
    
    private func setupCustomViews() {
        ratingContainerView.layer.cornerRadius = 10
    }
    
    private func registerCellToCollectionView() {
        popularMoviesCollectionView.register(UINib(nibName: PopularMoviesCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: PopularMoviesCollectionViewCell.nameOfClass)
        horizontolCollectionView.register(UINib(nibName: HorizontalCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: HorizontalCollectionViewCell.nameOfClass)
    }
}

//MARK: - Extensions
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesCollectionViewCell.nameOfClass, for: indexPath) as? PopularMoviesCollectionViewCell else { return UICollectionViewCell() }
            //Cell Configure Below
            cell.configureCell(apiResult: viewModel.movieResultArray[indexPath.row], posterImage: apiPosterImagesArray[indexPath.row])
            
            return cell
        }
        
        if collectionView == horizontolCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.nameOfClass, for: indexPath) as? HorizontalCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(posterImage: apiPosterImagesArray[indexPath.row])
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == popularMoviesCollectionView {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size: CGFloat = (collectionView.frame.size.width - space)
            return CGSize(width: size, height: 100)
        }
        
        if collectionView == horizontolCollectionView {
            return CGSize(width: 260, height: collectionView.frame.height)
        }
        return CGSize(width: 0, height: 0)
    }
    //MARK: - ScrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    //    //MARK: - Footer
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: 50, height: 30)
//    }
//    //MARK: - Header
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "", for: indexPath)
//        footer.backgroundColor = .black
//
//        return footer
//    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize(width: collectionView.frame.width, height: 250)
    //    }
}

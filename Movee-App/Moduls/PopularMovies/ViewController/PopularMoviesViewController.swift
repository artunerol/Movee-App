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

    //MARK: - Public Properties
    var viewModel: PopularMoviesViewModel? = nil
    
    //MARK: - Private Properties
    private var apiResult: [PopularMoviesResultResponse] = []
    private var apiPosterImagesArray: [UIImage] = []
    
    //MARK: - Lifce Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAPIResult()
        
        setupCollectionView()
        viewModel?.preparePopulerMovies()
    }
    
    //MARK: - API Result Handling
    
    private func handleAPIResult() {
        viewModel?.populerMoviesSuccessClosure = { [weak self] result in
            self?.apiResult = result
            self?.handleCellImageConvertingToData(imagePath: result, imageSize: .popularMoviesW500Poster)
            self?.PopularMoviesCollectionView.reloadData()
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
            print("image url String is \(urlString)")
            
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
        PopularMoviesCollectionView.delegate = self
        PopularMoviesCollectionView.dataSource = self
        addHeaderToCollectionView()
        addCellToCollectionView()
        
//        if let flowLayout = PopularMoviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = .init(width: PopularMoviesCollectionView.frame.width, height: 100)
//        }
    }

    private func addHeaderToCollectionView() {
        PopularMoviesCollectionView.register(
            PopularMoviesHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StaticStringsList.popularMoviesReusableHeader)
    }

    private func addCellToCollectionView() {
        PopularMoviesCollectionView.register(UINib(nibName: PopularMoviesCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: PopularMoviesCollectionViewCell.nameOfClass)
    }
}

//MARK: - Extensions
extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.movieResultArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesCollectionViewCell.nameOfClass, for: indexPath) as? PopularMoviesCollectionViewCell else { return UICollectionViewCell() }
        //Cell Configure Below
        cell.configureCell(apiResult: viewModel.movieResultArray[indexPath.row], posterImage: apiPosterImagesArray[indexPath.row])

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space)
        return CGSize(width: size, height: 100)
    }
    //MARK: - Header

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StaticStringsList.popularMoviesReusableHeader, for: indexPath)
                header.backgroundColor = .blue //Header ile ilgili renk vs UI configurationları kod yazarak yapıyorsak storyboardda header'ı renkli yapmam ne işe yarıyor?

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
}

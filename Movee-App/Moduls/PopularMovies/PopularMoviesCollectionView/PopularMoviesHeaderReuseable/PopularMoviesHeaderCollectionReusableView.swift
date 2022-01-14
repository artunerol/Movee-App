//
//  PopularMoviesHeaderCollectionReusableView.swift
//  Movee-App
//
//  Created by Artun Erol on 5.01.2022.
//

import UIKit

class PopularMoviesHeaderCollectionReusableView: UICollectionReusableView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movies"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 34)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            label.topAnchor.constraint(equalTo: topAnchor,constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

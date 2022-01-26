//
//  AutoSizedCollectionView.swift
//  Movee-App
//
//  Created by Ismail Kilic on 19.01.2022.
//

import UIKit

class AutoSizedCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

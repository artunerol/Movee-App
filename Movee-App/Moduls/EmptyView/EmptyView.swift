//
//  EmptyView.swift
//  Movee-App
//
//  Created by Erol, Artun on 9.02.2022.
//

import UIKit

class EmptyView: UIView {
    @IBOutlet private var containerView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

//
//  PersonDetailViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 26.01.2022.
//

import UIKit
import Kingfisher

class PersonDetailViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private weak var personImageView: UIImageView!
    @IBOutlet private weak var personNameLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var fullBioLabelButton: UILabel!
    @IBOutlet private weak var birthLabel: UILabel!

    // MARK: - Private Vars
    var viewModel: PersonDetailViewModel?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfigurations()

        viewModel?.apiRequest()
    }
    // MARK: - Private funcs
    private func setupViewConfigurations() {
        setPersonDetail()
        addActionToBioLabel()
    }

    private func setPersonDetail() {
        viewModel?.personDetailSuccess = { [weak self] in
            guard let self = self, let viewModel = self.viewModel else { return }
            if let profilePath = viewModel.personDetail?.profilePath {
                let imageURLString = StaticStringsList.imageBaseURL + ServiceURL.popularMoviesW500Poster.description + profilePath
                guard let imageURL = URL(string: imageURLString) else { return }
                self.personImageView.kf.setImage(with: imageURL)
            } else {
                self.personImageView.image = UIImage(systemName: "person.fill")
            }
            let birthDay = viewModel.personDetail?.birthday ?? "Birthday"
            let birthPlace = viewModel.personDetail?.placeOfBirth ?? "PlaceOfBirth"
            self.personNameLabel.text = viewModel.personDetail?.name
            self.bioLabel.text = viewModel.personDetail?.biography
            self.birthLabel.text = birthDay + " in " + birthPlace
        }
    }

    // MARK: - BioLabel Actions

    private func addActionToBioLabel() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        fullBioLabelButton.addGestureRecognizer(gesture)
    }

    @objc private func buttonTapped() {
        bioLabel.numberOfLines = 0
        bioLabel.isHighlighted = true
        fullBioLabelButton.isHidden = true
    }
}

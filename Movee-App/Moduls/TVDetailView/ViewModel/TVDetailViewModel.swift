//
//  DetailViewModel.swift
//  Movee-App
//
//  Created by Erol, Artun on 20.01.2022.
//

import Foundation
import UIKit
import Alamofire

class TVDetailViewModel {
    var model: DetailModel
    var castResultArray: [CastResultResponse] = []
    var tvDetailResult: TVSeriesDetailResponse?
    var castResultSuccess: (() -> Void)?
    var tvDetailSuccess: (() -> Void)?

    init(model: DetailModel) {
        self.model = model
    }

    func prepareData(castType: DetailCastType) {
        switch castType {
        case .tvSeries:
            tvCastAPIHandler()
            tvDetailAPIHandler()
        case .movies:
            break
        }
    }

    // MARK: - Private Funcs
    private func tvCastAPIHandler() {
        NetworkManager.shared.request(
            url: .tvCast(model.id.string()),
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: CastResponse.self,
            success: { [weak self] response in
                self?.castResultSuccess?()
                self?.castResultArray = response.cast ?? []
            }, failure: { error in
                print("cast error in detailviewmodel is \(String(describing: error.errorDescription))")
            }
        )
    }

    private func tvDetailAPIHandler() {
        DispatchQueue.main.async { [weak self] in
            guard let id = self?.model.id.string() else { return }
            NetworkManager.shared.request(
                url: .tvDetail(id),
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                responseObjectType: TVSeriesDetailResponse.self,
                success: { [weak self] result in
                    self?.tvDetailSuccess?()
                    self?.tvDetailResult = result
                },
                failure: { error in
                    print("error in tvdetail \(error)")
                }
            )
        }
    }
}
// MARK: -
struct DetailModel {
    var titleLabel: String
    var releaseDate: String
    var overView: String
    var posterImage: String
    var id: Int
    var rating: String
}

enum DetailCastType: String {
    case tvSeries
    case movies
}

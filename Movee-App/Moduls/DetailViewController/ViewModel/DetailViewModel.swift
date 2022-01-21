//
//  DetailViewModel.swift
//  Movee-App
//
//  Created by Erol, Artun on 20.01.2022.
//

import Foundation
import UIKit
import Alamofire

class DetailViewModel {
    var model: DetailModel
    var castResultArray: [CastResultResponse] = []
    var castResultSuccess: (() -> Void)?

    init(model: DetailModel) {
        self.model = model
    }

    func prepareCastData(castType: DetailCastType) {
        switch castType {
        case .tv:
            tvCastAPIHandler()
        case .movies:
            movieCastAPIHandler()
        }
    }

    //MARK: - Private Funcs

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
                print("cast error in detailviewmodel is \(error.errorDescription)")
            })
    }

    private func movieCastAPIHandler() {
        NetworkManager.shared.request(
            url: .movieCast(model.id.string()),
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: CastResponse.self,
            success: { [weak self] response in
                self?.castResultSuccess?()
                self?.castResultArray = response.cast ?? []
            }, failure: { error in
                print("cast alınamadı")
            })
    }
}
//MARK: -
struct DetailModel {
    var titleLabel: String
    var releaseDate: String
    var overView: String
    var posterImage: String
    var id: Int
}

enum DetailCastType:String {
    case tv
    case movies
}

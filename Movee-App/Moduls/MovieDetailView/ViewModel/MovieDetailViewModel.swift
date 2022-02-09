//
//  Movee-App
//
//  Created by Erol, Artun on 20.01.2022.
//

import Foundation
import UIKit
import Alamofire

class MovieDetailViewModel {
    var model: DetailModel
    var castResultArray: [CastResultResponse] = []
    var movieDetailResult: MovieDetailResponse?
    var castResultSuccess: (() -> Void)?
    var movieDetailSuccess: (() -> Void)?

    init(model: DetailModel) {
        self.model = model
    }

    func prepareCastData() {
        movieCastAPIHandler()
        movieDetailAPIHandler()
    }

    // MARK: - Private Funcs
    private func movieCastAPIHandler() {
        NetworkManager.shared.request(
            url: .movieCast(model.id.string()),
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: CastResponse.self,
            success: { [weak self] response in
                self?.castResultArray = response.cast ?? []
                self?.castResultSuccess?()
            }, failure: { _ in
                print("cast alınamadı")
            }
        )
    }

    private func movieDetailAPIHandler() {
        NetworkManager.shared.request(
            url: .movieDetail(model.id.string()),
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: MovieDetailResponse.self,
            success: { [weak self] result in
                self?.movieDetailResult = result
                self?.movieDetailSuccess?()
            },
            failure: { error in
                print("error in tvdetail \(error)")
            }
        )
    }
}

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
    var castResultSuccess: (() -> Void)?

    init(model: DetailModel) {
        self.model = model
    }

    func prepareCastData(castType: DetailCastType) {
        switch castType {
        case .tvSeries:
            break
        case .movies:
            movieCastAPIHandler()
        }
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
                self?.castResultSuccess?()
                self?.castResultArray = response.cast ?? []
            }, failure: { _ in
                print("cast alınamadı")
            }
        )
    }
}

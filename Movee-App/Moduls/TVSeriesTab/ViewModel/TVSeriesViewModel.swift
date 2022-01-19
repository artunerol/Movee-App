//
//  TVSeriesViewModel.swift
//  Movee-App
//
//  Created by Erol, Artun on 19.01.2022.
//

import Foundation
import Alamofire

class TVSeriesViewModel {
    var tvSeriesResultArray: [TopRatedResultResponse] = []
    var popularTVSeriesSuccessClosure: (([TopRatedResultResponse]) -> Void)?
    var popularTVSeriesFailedClosure: ((String) -> Void)?

    func preparePopularTVSeries() {
        NetworkManager.shared.request(url: .topRatedTVSeriesURL,
                                      method: .get,
                                      parameters: nil,
                                      encoding: URLEncoding.default,
                                      responseObjectType: TopRatedResponse.self) { [weak self] response in
            self?.tvSeriesResultArray = response.results ?? []
            self?.popularTVSeriesSuccessClosure?(response.results ?? [])
        } failure: { [weak self] error in
            self?.popularTVSeriesFailedClosure?(error.localizedDescription)
        }

    }

}

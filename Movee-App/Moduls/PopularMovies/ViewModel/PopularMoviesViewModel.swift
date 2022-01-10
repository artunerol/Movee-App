//
//  PopularMoviesViewModel.swift
//  Movee-App
//
//  Created by Ismail Kilic on 7.01.2022.
//

import Foundation
import Alamofire

class PopularMoviesViewModel {
 

    var movieResultArray: [PopulerMoviesResultResponse] = []
    var populerMoviesSuccessClosure: (([PopulerMoviesResultResponse]) -> Void)?
    var populerMoviesFailedClosure: ((String) -> Void)?

    func preparePopulerMovies() {
        NetworkManager.shared.request(
            url: .populerMoviesURL,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: PopulerMoviesResponse.self,
            success: { [weak self] response in
                self?.movieResultArray = response.results ?? []
                self?.populerMoviesSuccessClosure?(response.results ?? [])
            }, failure: { [weak self] error in
                self?.populerMoviesFailedClosure?("Popüler filmler alınamadı")
            })
    }
}

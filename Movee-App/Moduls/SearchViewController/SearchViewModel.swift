//
//  SearchViewModel.swift
//  Movee-App
//
//  Created by Erol, Artun on 7.02.2022.
//

import Foundation
import Alamofire

class SearchViewModel {
    var searchResultArray: [SearchResultAPIResponse] = []
    var searchSuccessClosure: (([SearchResultAPIResponse]) -> Void)?
    var searchFailedClosure: ((String) -> Void)?

    func search(keyword: String) {
        NetworkManager.shared.request(
            url: .search(keyword),
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: SearchAPIResponse.self,
            success: { [weak self] response in
                self?.searchResultArray = response.results ?? []
                self?.searchSuccessClosure?(response.results ?? [])
            }, failure: { [weak self] _ in
                self?.searchFailedClosure?("Popüler filmler alınamadı")
            }
        )
    }
}

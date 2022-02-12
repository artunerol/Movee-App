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
    var castResultArray: [CastResultResponse] = []
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

    func fetchSubData(id: Int, type: MediaType) {
        switch type {
        case .tvision:
            NetworkManager.shared.request(
                url: .tvCast(id.string()),
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                responseObjectType: CastResponse.self,
                success: { [weak self] response in
                    self?.castResultArray = response.cast ?? []
                }, failure: { [weak self] _ in
                    self?.searchFailedClosure?("Popüler filmler alınamadı")
                }
            )
        case .movie:
            NetworkManager.shared.request(
                url: .movieCast(id.string()),
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                responseObjectType: CastResponse.self,
                success: { [weak self] response in
                    self?.castResultArray = response.cast ?? []
                }, failure: { [weak self] _ in
                    self?.searchFailedClosure?("Popüler filmler alınamadı")
                }
            )
        case .person:
            NetworkManager.shared.request(
                url: .person(id),
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                responseObjectType: PersonAPIResponse.self,
                success: { [weak self] _ in

                }, failure: { [weak self] _ in
                    self?.searchFailedClosure?("Popüler filmler alınamadı")
                }
            )
        case .defaultType:
            break
        }
    }
}

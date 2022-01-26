//
//  PersonDetailViewModel.swift
//  Movee-App
//
//  Created by Erol, Artun on 26.01.2022.
//

import Foundation
import Alamofire

class PersonDetailViewModel {
    var personDetail: PersonAPIResponse?
    var personDetailSuccess: (() -> Void)?
    private let id: Int

    init(id: Int) {
        self.id = id
    }

    func apiRequest() {
        NetworkManager.shared.request(
            url: .person(id),
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: PersonAPIResponse.self,
            success: { [weak self] result in
                self?.personDetail = result
                self?.personDetailSuccess?()
            },
            failure: { error in
                print("error in getting person detail is \(error)")
            }
        )
    }
}

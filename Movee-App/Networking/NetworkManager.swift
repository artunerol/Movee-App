//
//  NetworkManager.swift
//  Movee-App
//
//  Created by Artun Erol on 5.01.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    func get<T: Codable>(url: ServiceURL, type: T.Type, response: @escaping ((T) -> Void))
}

class NetworkManager {
    static let shared = NetworkManager()

    // MARK: - Private funcs
    
    func request<T: Decodable>(url: ServiceURL,
                               method: HTTPMethod,
                               parameters: Parameters?,
                               encoding: ParameterEncoding,
                               responseObjectType: T.Type,
                               success: @escaping (T) -> Void,
                               failure: @escaping (AFError) -> Void) {
        let requestURL = StaticStringsList.baseURL + url.description + StaticStringsList.apiKeyParam
        let request = AF.request(
            requestURL,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: nil
        )
        request
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    success(data)
                case .failure(let error):
                    failure(error)
                }
            }
    }

   private func convenienceGetRequest<T: Codable>(url: ServiceURL, type: T.Type, success: ((T) -> Void)?) {
        NetworkManager.shared.request(
            url: url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: type.self,
            success: { responseSuccess in
                success?(responseSuccess)
            },
            failure: { _ in
                print("getRequestShort Error")
            }
        )
    }
}

// MARK: - Extensions

extension NetworkManager: NetworkManagerProtocol {
    func get<T>(url: ServiceURL, type: T.Type, response: @escaping ((T) -> Void)) where T: Decodable, T: Encodable {
        convenienceGetRequest(
            url: url,
            type: type,
            success: response
        )
    }
}

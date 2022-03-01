//
//  LoginViewModel.swift
//  Movee-App
//
//  Created by Erol, Artun on 15.02.2022.
//

import Foundation
import Alamofire

class LoginViewModel {
    var tokenRequestSucess: ((String) -> Void)?
    var loginRequestSucess: ((Bool) -> Void)?

    func tokenRequest() {
        NetworkManager.shared.request(
            url: .requestToken,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            responseObjectType: RequestTokenResponse.self,
            success: { [weak self] response in
                self?.tokenRequestSucess?(response.requestToken ?? "")
            },
            failure: { _ in
                print("request token error")
            }
        )
    }

    func loginRequest(with parameters: [String: Any]) {
        NetworkManager.shared.request(
            url: .loginRequest,
            method: .post,
            parameters: parameters,
            encoding: URLEncoding.default,
            responseObjectType: LoginRequest.self,
            success: { [weak self] _ in
                self?.loginRequestSucess?(true)
            },
            failure: { _ in
                print("Login Request Error")
            }
        )
    }
}

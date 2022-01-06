//
//  NetworkManager.swift
//  Movee-App
//
//  Created by Artun Erol on 5.01.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func fetchData<T: Codable>(as: T.Type) {
        let request = AF.request(StaticStringsList.myURL)
        request.responseDecodable(of: T.self) { response in
            print("Response is \(response)")
        }
    }
}

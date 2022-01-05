//
//  NetworkManager.swift
//  Movee-App
//
//  Created by Artun Erol on 5.01.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func fetchData() {
        let request = AF.request(StaticStringsList.myURL)
        request.responseDecodable(of: APIData.self) { response in
            print("Response is \(response)")
        }
    }
}

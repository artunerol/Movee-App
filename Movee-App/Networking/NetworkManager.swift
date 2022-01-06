//
//  NetworkManager.swift
//  Movee-App
//
//  Created by Artun Erol on 5.01.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    //Fetch data func'ı kontrol edelim
    
    func fetchData<T: Codable>(as: T.Type, with completion: @escaping (T) -> Void) {
        let request = AF.request(StaticStringsList.myURL)
        request.responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
                completion(data)
            case .failure(_):
                print("AF cant get any Result out of JSON")
            }
            
        }
    }
}

//
//  Notification.Name+Extension.swift
//  Movee-App
//
//  Created by Artun Erol on 6.01.2022.
//

import Foundation

extension Notification.Name {
    static func apiDataObserver() -> Self {
        return Notification.Name(rawValue: StaticStringsList.apiDataObserver)
    }
}

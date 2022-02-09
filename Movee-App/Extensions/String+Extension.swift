//
//  String+Extension.swift
//  Movee-App
//
//  Created by Erol, Artun on 7.02.2022.
//

import Foundation

extension String {
    func removeSpaces() -> Self {
        trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "%20")
    }
}

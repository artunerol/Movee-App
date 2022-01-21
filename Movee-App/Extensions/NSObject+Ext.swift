//
//  NSObject+Ext.swift
//  Movee-App
//
//  Created by Ismail Kilic on 7.01.2022.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        String(describing: self)
    }
}

//
//  Extensions.swift
//  ContactGame
//
//  Created by Beliy.Bear on 09.07.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}

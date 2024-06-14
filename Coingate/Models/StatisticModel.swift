//
//  StatisticModel.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/9/21.
//

import Foundation
import SwiftUI

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let image: String
    let value: String
    let background: Color
    let percentageChange: Double?
    
    init(title: String, image: String, value: String, background: Color, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.image = image
        self.background = background
        self.percentageChange = percentageChange
    }
}

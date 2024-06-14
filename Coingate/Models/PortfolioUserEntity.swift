//
//  PortfolioEntity.swift
//  Coingate
//
//  Created by Victor on 12/11/2023.
//

import Foundation

struct PortfolioUserEntity: Codable {
    let coinID: String
    var amount: Double

    enum CodingKeys: String, CodingKey {
        case coinID
        case amount
    }
}

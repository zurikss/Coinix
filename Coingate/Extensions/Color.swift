//
//  Color.swift
//  Coingate
//
//  Created by Victor on 27/10/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let gray900 = Color("Gray900")
    let gray600 = Color("Gray600")
    let gray400 = Color("Gray400")
    let gray500 = Color("Gray500")
    let gray200 = Color("Gray200")
    let gray100 = Color("Gray100")
    let gray50 = Color("Gray50")
    let button500 = Color("Button500")
    let white100 = Color("White100")
    let white000 = Color("White000")
    let green900 = Color("Green900")
    let red900 = Color("Red900")
    let layer100 = Color("Layer100")
    let primaryButton = Color("PrimaryButton")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}



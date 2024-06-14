//
//  SettingsViewModel.swift
//  Coingate
//
//  Created by Victor on 13/11/2023.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var selectedFace: String = ""
    @Published var balanceIcon: String = ""
    @Published var hideBalance: Bool = false
    @Published var isOn: Bool = false
    @Published var showMode: Bool = false
    @Published var selectedTheme: Int = 0

    @Published var facesArray = [
        "◦◦◦◦◦◦◦◦",
        "(▀ ͜ʖ ͡°)",
        "༼ಢ_ಢ༽",
        "(〒︿〒)",
        "(´･_･`)",
        "(ס_ס;;)",
        "(×_×)",
        "(^ω^)",
        "(ﾉ◕ヮ◕)ﾉ*:・ﾟ✧",
        "(¬‿¬)",
        "(≧◡≦)",
        "(¬▂¬)",
        "(≧ω≦)",
        "(¬_¬)",
        "(ﾉ^_^)ﾉ",
        "(⌐■_■)",
        "(´∀｀)",
        "(｡♥‿♥｡)",
        "(¬з¬)",
        "(¬ω¬)",
        "(✿◠‿◠)",
        "(◕‿◕)",
        "(ﾟヮﾟ)",
        "(≧∇≦)",
        "(*≧ω≦)",
        "(●´∀｀●)",
        "(¬⌣¬)",
        "(◠‿◠✿)",
        "(>ω<)",
        "(¬‿¬)ﾉ"
    ]
    
    @Published var themes: [String] = [
        "light",
        "dark",
        "system"
    ]
    
    @Published var themeNames: [String] = [
        "Light",
        "Dark",
        "System"
    
    ]
    
    let defaults = UserDefaults.standard
    
    struct Keys {
        static let selectedFace = "selectedFace"
        static let balanceIcon = "balanceIcon"
        static let hideBalance = "hideBalance"
        static let isOn = "isOn"
        static let selectedTheme = "selectedTheme"
    }
    
    init() {
        checkForIcons()
        checkForBalance()
        checkForTheme()
    }
    
    
    func saveToUserDefaults() {
        defaults.set(selectedFace, forKey: Keys.selectedFace)
        defaults.setValue(balanceIcon, forKey: Keys.balanceIcon)
       
       
    }
    
    func checkForIcons() {
        let selectedFaceUD = defaults.value(forKey: Keys.selectedFace) as? String ?? ""
        let balanceIconUD = defaults.value(forKey: Keys.balanceIcon) as? String ?? ""
        
        
        selectedFace = selectedFaceUD
        balanceIcon = balanceIconUD
    }
    
    func saveHideBalance() {
        defaults.setValue(hideBalance, forKey: Keys.hideBalance)
        defaults.setValue(isOn, forKey: Keys.isOn)
    }
    
    func checkForBalance() {
        let hideBalanceUD = defaults.bool(forKey: Keys.hideBalance)
        let isOnUD = defaults.bool(forKey: Keys.isOn)
        if hideBalanceUD {
            hideBalance = true
        }
        if isOnUD {
            isOn = true
        }
        
    }
    
    func saveTheme() {
        defaults.setValue(selectedTheme, forKey: Keys.selectedTheme)
    }
    
    func checkForTheme() {
        let selectedThemeUD = defaults.integer(forKey: Keys.selectedTheme)
        selectedTheme = selectedThemeUD
    }
    
    
}

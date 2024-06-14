//
//  CoingateApp.swift
//  Coingate
//
//  Created by Victor on 27/10/2023.
//

import SwiftUI

@main
struct CoingateApp: App {
    
    @StateObject private var viewModel = CoinsViewModel()
    @StateObject private var sheetManager = SheetManager()
    @StateObject private var portfolio = PortfolioViewModel()
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var modeSheetManager = ModeSheetManager()
    @StateObject private var appIconManager = AppIconSheetManager()
    @State private var showLaunchView: Bool = true
    
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchemeType.allCases.first!.rawValue
    
    private var selectedScheme: ColorScheme? {
        guard let theme = SchemeType(rawValue: systemTheme) else { return nil }
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }

    @Namespace private var namespace
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                NavigationView(content: {
                    MarketView()
                            .navigationBarHidden(true)
                })
                .preferredColorScheme(selectedScheme)
                .environmentObject(viewModel)
                .environmentObject(NamespaceWrapper(namespace))
                .environmentObject(SheetManager())
                .environmentObject(PortfolioViewModel())
                .environmentObject(settingsViewModel)
                .environmentObject(modeSheetManager)
                .environmentObject(appIconManager)
                
//                ZStack(content: {
//                    if showLaunchView {
//                        LaunchView(showLaunchView: $showLaunchView)
//                            .transition(.opacity.animation(.easeOut(duration: 0.3)))
//                    }
//                })
                
                ZStack(content: {
                    if showLaunchView {
                        LaunchLottieView(showLaunchView: $showLaunchView)
                            .transition(.opacity.animation(.easeOut(duration: 0.3)))
                    }
                    
                })
                .zIndex(2.0)
            }
            
            
            
           
        }
        
    }
}

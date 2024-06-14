//
//  ThemeView.swift
//  Coingate
//
//  Created by Victor on 25/11/2023.
//

import SwiftUI

enum SchemeType: Int, Identifiable, CaseIterable {
    var id: Self { self }
    case light
    case dark
    case system
}

extension SchemeType {
    var title: String {
        switch self {
        case .system:
            return "Light"
        case .light:
            return "Dark"
        case .dark:
            return "System"
        }
    }
}

struct ThemeView: View {

    @EnvironmentObject private var settingsViewModel: SettingsViewModel
    //@State private var isSelected: Int = 0
    
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
    
    var body: some View {
        HStack(spacing: 0) {
            //Spacer()
            ForEach(settingsViewModel.themes.indices, id: \.self) { index in
                let theme = settingsViewModel.themes[index]
                let themeName = settingsViewModel.themeNames[index]
                let schemeType = SchemeType.allCases[index]
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    Image(theme)
                        .resizable()
                        .frame(width: 70, height: 109, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .padding(4)
                        .overlay(alignment: .center) {
                            RoundedRectangle(cornerRadius: 27, style: .continuous)
                                .stroke(lineWidth: settingsViewModel.selectedTheme == index ? 2.5 : 0)
                        }
                    Text(themeName)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(settingsViewModel.selectedTheme == index ? .white000 : .gray900)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                        .background(settingsViewModel.selectedTheme == index ? .gray900 : .gray200)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                }
                .tag(schemeType.rawValue)
                .onTapGesture {
                    changeTheme(index: index)
                    HapticsManager.instance.impact(style: .soft)
                }
                Spacer()
            }

        }
        .fontDesign(.rounded)
        .padding(.bottom, 32)
    }
    
    private func changeTheme(index: Int) {
        settingsViewModel.selectedTheme = index
        systemTheme = SchemeType.allCases[index].rawValue
        settingsViewModel.saveTheme() // Save selectedTheme to UserDefaults
        HapticsManager.instance.impact(style: .soft)
    }
}

#Preview {
    ThemeView()
        .environmentObject(SettingsViewModel())
}

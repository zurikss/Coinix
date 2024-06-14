//
//  AppIconView.swift
//  Coingate
//
//  Created by Victor on 04/12/2023.
//

import SwiftUI

struct AppIconView: View {
    
//    @EnvironmentObject var portfolioViewModel: PortfolioViewModel
//    @EnvironmentObject var coinsViewModel: CoinsViewModel
    @EnvironmentObject private var sheetManager: SheetManager
    
    let icons: [String] = ["black", "pink", "glass", "blue", "purple", "light_blue", "brick", "red", "orange", "crystal", "green", "original" ]
    
    let customIcons: [String] = ["AppIcon 1", "AppIcon 2", "AppIcon 3", "AppIcon 4", "AppIcon 5", "AppIcon 6", "AppIcon 7", "AppIcon 8", "AppIcon 9", "AppIcon 10", "AppIcon 11"]
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
    ]
    
    @AppStorage("active_icon") var activeAppIcon: String = "AppIcon"
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(icons.indices, id: \.self) { appIcon in
                        Button {
                            activeAppIcon = customIcons[appIcon]
                            HapticsManager.instance.impact(style: .soft)
                            withAnimation(.spring) {
                                sheetManager.dismiss()
                            }
                        } label: {

                            Image(icons[appIcon])
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                                .tag(appIcon)
                        }
                        .buttonStyle(BouncyButton())
                        .onChange(of: activeAppIcon) { newValue in
                            UIApplication.shared.setAlternateIconName(newValue)
                        }
                    }
                }
                .padding(.bottom, 24)
                .padding(.top, 8)
            }
            .overlay(alignment: .top) {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(height: 14)
                  .frame(maxWidth: .infinity)
                  .background(
                    LinearGradient(
                      stops: [
                        Gradient.Stop(color: .layer100, location: 0.00),
                        Gradient.Stop(color: .layer100.opacity(0), location: 1.00),
                      ],
                      startPoint: UnitPoint(x: 0.5, y: 0),
                      endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                  )
            }
            .overlay(alignment: .bottom) {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(height: 30)
                  .frame(maxWidth: .infinity)
                  .background(
                    LinearGradient(
                      stops: [
                        Gradient.Stop(color: .layer100, location: 1.00),
                        Gradient.Stop(color: .layer100.opacity(0), location: 0.00),
                      ],
                      startPoint: UnitPoint(x: 0.5, y: 0),
                      endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                  )
            }
            
        }
        .frame(height: 250)
        .transition(.asymmetric(
            insertion: .scale(scale: 0.8, anchor: .bottom).combined(with: .opacity).animation(.spring(response: 0.22, dampingFraction: 1, blendDuration: 1)),
            removal: .scale(scale: 0.8).combined(with: .opacity).animation(.spring(response: 0.07, dampingFraction: 1, blendDuration: 1))))

    }
}

#Preview {
    AppIconView()
}





//
//  IconsView.swift
//  Coingate
//
//  Created by Victor on 03/11/2023.
//

import SwiftUI

struct IconsView: View {
    
    @EnvironmentObject var viewModel: PortfolioViewModel
    @EnvironmentObject private var sheetManager: SheetManager


    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    let iconNames: [String] = [
        "activity",
        "alert-circle",
        "alert-triangle",
        "archive",
        "arrow-circle-down",
        "arrow-circle-left",
        "arrow-circle-right",
        "arrow-circle-up",
        "arrow-ios-up",
        "arrow-right",
        "arrowhead-down",
        "arrowhead-left",
        "arrowhead-right",
        "arrowhead-up",
        "award",
        "bar-chart-2",
        "bar-chart",
        "battery",
        "batttery-charging",
        "bell-off",
        "bluetooth",
        "book",
        "bookmark",
        "briefcase",
        "bulb",
        "calendar",
        "camera",
        "cast",
        "checkmark-circle-2",
        "checkmark-square-2",
        "checkmark",
        "cloud-download",
        "cloud-upload",
        "copy",
        "corner-down-left",
        "corner-down-right",
        "corner-left-down",
        "corner-left-up",
        "corner-right-down",
        "corner-right-up",
        "corner-up-left",
        "corner-up-right",
        "credit-card",
        "diagonal-arrow-left-down",
        "diagonal-arrow-left-up",
        "diagonal-arrow-right-down",
        "diagonal-arrow-right-up",
        "download",
        "edit-2",
        "edit",
        "external-link",
        "eye-off",
        "eye",
        "file-add",
        "file-remove",
        "file-text",
        "file",
        "flash-off",
        "flash",
        "folder-add",
        "folder-remove",
        "folder",
        "funnel",
        "grid",
        "hard-drive",
        "hash",
        "headphones",
        "heart",
        "home",
        "image-1",
        "image",
        "inbox",
        "info",
        "layers",
        "layout",
        "link-2",
        "link",
        "list",
        "loader",
        "map",
        "menu",
        "message-circle",
        "message-square",
        "mic-off",
        "mic",
        "minus-square",
        "monitor",
        "more-horizontal",
        "move",
        "music",
        "paper-plane",
        "people",
        "person-add",
        "person-delete",
        "person-done",
        "person-remove",
        "person",
        "plus-square",
        "pricetag",
        "save",
        "scissors",
        "settings-2",
        "settings",
        "shopping-bag",
        "shopping-cart",
        "shuffle-2",
        "shuffle",
        "slash",
        "square",
        "thermometer-minus",
        "thermometer-plus",
        "thermometer",
        "trash-2",
        "trash",
        "trending-down",
        "trending-up",
        "upload",
        "wifi-off",
        "wifi",
        "Envelope",
        "Like",
        "Gamepad",
        "Mouse-alt",
        "Processor",
        "Current-location",
        "Globe",
        "Heart",
        "Star"
    ]


    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(iconNames, id: \.self) { icon in
                        Button {
                            viewModel.portfolioIconProfile = icon
                            viewModel.portfolioImageProfile = ""
                            viewModel.portfolioTextProfile = ""
                            withAnimation(.spring) {
                                sheetManager.dismiss()
                            }
                            viewModel.saveAllProfile()
                        } label: {
                            Image(icon)
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray500)
                        }
                        .buttonStyle(BouncyButton())
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
        .frame(height: 260)
        .transition(.asymmetric(
            insertion: .scale(scale: 0.8, anchor: .bottom).combined(with: .opacity).animation(.spring(response: 0.22, dampingFraction: 1, blendDuration: 1)),
            removal: .scale(scale: 0.8).combined(with: .opacity).animation(.spring(response: 0.07, dampingFraction: 1, blendDuration: 1))))
    }
}

#Preview {
    IconsView()
}

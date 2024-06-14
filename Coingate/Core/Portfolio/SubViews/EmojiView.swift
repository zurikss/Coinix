//
//  EmojiView.swift
//  Coingate
//
//  Created by Victor on 02/11/2023.
//

import SwiftUI

struct EmojiView: View {
    
    @EnvironmentObject var portfolioViewModel: PortfolioViewModel
    @EnvironmentObject var coinsViewModel: CoinsViewModel
    @EnvironmentObject private var sheetManager: SheetManager

    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    let emojis: [String] = [
        "😀", "😃", "😄", "😁", "😆", "😂", "🥹", "🥲", "🤣", "😍",
        "😘", "🥰", "😜", "😎", "🤪", "😤", "😏", "🤩", "🥳", "🥺",
        "😚", "😭", "🥸", "🤓", "😒", "😞", "😔", "😟", "😕", "😫",
        "😖", "😶‍🌫️", "🤔", "🫣", "🫢", "🫠", "🫤", "😬", "😮",
        "🥱", "🤯", "😡", "🤭", "💀", "😹", "🙀", "🥶", "🫥", "🤬",
        "😯", "😦", "😧", "😵", "🤢", "😵‍💫", "🤤", "😷", "🤒",
        "🤕", "🤑", "🤠", "😈", "👹", "👺", "🤡", "💩", "👻",
        "☠️", "👽", "👾", "🤖", "🎃", "😺",
        "🦄", "🐶", "🐱", "🐭", "🐻", "🦊", "🐼", "🦁", "🐮", "🐷",
        "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐣", "🐥", "🦉", "🦆",
        "🌞", "🌝", "🌛", "🌜", "🌚", "🌍", "🌎", "🌏", "🌕", "🌖",
        "🌗", "🌘", "🌑", "🌒", "🌓", "🌔", "👀", "🌙", "🌟", "⭐",
        "🌠", "💫", "✨", "☀️", "🌻", "🌼", "🌷", "🌸", "💐", "🌹", "🧠", "💋", "🍄"
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button {
                            portfolioViewModel.portfolioTextProfile = emoji
                            portfolioViewModel.portfolioImageProfile = ""
                            portfolioViewModel.portfolioIconProfile = ""
                            portfolioViewModel.saveAllProfile()
                            print("Emoji tapped")
                            withAnimation(.spring) {
                                sheetManager.dismiss()
                            }
                        } label: {
                            Text(emoji)
                                .font(.title)
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
        .frame(height: 250)
        .transition(.asymmetric(
            insertion: .scale(scale: 0.8, anchor: .bottom).combined(with: .opacity).animation(.spring(response: 0.22, dampingFraction: 1, blendDuration: 1)),
            removal: .scale(scale: 0.8).combined(with: .opacity).animation(.spring(response: 0.07, dampingFraction: 1, blendDuration: 1))))
    }
}

#Preview {
    EmojiView()
        .previewLayout(.sizeThatFits)
        .environmentObject(CoinsViewModel())
        .environmentObject(PortfolioViewModel())
}

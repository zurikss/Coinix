//
//  MemojiView.swift
//  Coingate
//
//  Created by Victor on 03/11/2023.
//

import SwiftUI

struct MemojiView: View {
    
    @EnvironmentObject var viewModel: PortfolioViewModel
    @EnvironmentObject private var sheetManager: SheetManager
    @EnvironmentObject var coinsViewModel: CoinsViewModel

    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    let memojis: [String] = [
        "memoji1",
        "memoji2",
        "memoji3",
        "memoji4",
        "memoji5",
        "memoji6",
        "memoji7",
        "memoji8",
        "memoji9",
        "memoji10",
        "memoji11",
        "memoji12",
        "memoji13",
        "memoji14",
        "memoji15",
        "memoji16",
        "memoji17",
        "memoji18",
        "memoji19",
        "memoji20",
        "memoji21",
        "memoji22",
        "memoji23",
        "memoji24",
        "memoji25",
        "memoji26",
        "memoji27",
        "memoji28"
    ]

    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(memojis, id: \.self) { memoji in
                        Button {
                            viewModel.portfolioImageProfile = memoji
                            viewModel.portfolioIconProfile = ""
                            viewModel.portfolioTextProfile = ""
                            withAnimation(.spring) {
                                sheetManager.dismiss()
                            }
                            viewModel.saveAllProfile()

                        } label: {
                            Image(memoji)
                                .resizable()
                                .frame(width: 69, height: 69, alignment: .center)
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
        
        .frame(height: 280)
        .transition(.asymmetric(
            insertion: .scale(scale: 0.8, anchor: .bottom).combined(with: .opacity).animation(.spring(response: 0.22, dampingFraction: 1, blendDuration: 1)),
            removal: .scale(scale: 0.8).combined(with: .opacity).animation(.spring(response: 0.07, dampingFraction: 1, blendDuration: 1))))
    }
}

#Preview {
    MemojiView()
        .environmentObject(CoinsViewModel())
        .environmentObject(PortfolioViewModel())
}

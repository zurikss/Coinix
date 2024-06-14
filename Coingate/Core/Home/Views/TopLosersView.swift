//
//  TopLosersView.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import SwiftUI

struct TopLosersView: View {
    
    let coin: CoinModel
    @EnvironmentObject var viewModel: CoinsViewModel
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailedView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Top Losers")
                .font(.title2)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .foregroundStyle(Color.theme.gray900)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 16) {
                    if viewModel.sortedLosersCoins.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(viewModel.sortedLosersCoins.prefix(7)) { coin in
                            TopGainerCoinView(coin: coin)
                                .onTapGesture {
                                    segue(coin: coin)
                                }
                        }
                    }
                }
            })
            .padding(.horizontal, 16)
        }
        .sheet(isPresented: $showDetailedView, onDismiss: nil, content: {
            DetailLoadingView(coin: $selectedCoin)
        })
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailedView.toggle()
    }
}

struct TopLosersView_Previews: PreviewProvider {
    static var previews: some View {
        TopLosersView(coin: dev.coin)
            .environmentObject(dev.coinViewModel)
    }
}

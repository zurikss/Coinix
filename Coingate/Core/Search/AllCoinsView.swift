//
//  AllCoinsView.swift
//  Coingate
//
//  Created by Victor on 01/11/2023.
//

import SwiftUI

struct AllCoinsView: View {
    
    @EnvironmentObject private var viewModel: CoinsViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailedView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.white000.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 24 ,content: {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 32) {
                                    ForEach(viewModel.allCoins) { coin in
                                        Button {
                                            segue(coin: coin)
                                        } label: {
                                            CoinRowView(coin: coin)
                                        }
                                        .buttonStyle(BouncyButton())
                                    }
                            }
                        }
                    })
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .sheet(isPresented: $showDetailedView, onDismiss: nil, content: {
                        DetailLoadingView(coin: $selectedCoin)
                    })
                
                .navigationTitle("Coins")
                    .navigationBarTitleDisplayMode(.inline)
            }
//                .toolbar(content: {
//                    ToolbarItem(placement: .principal) {
//                        Text("Coins")
//                            .fontDesign(.rounded)
//                            .font(.title)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(Color.theme.gray900)
//                    }
//                })
        }

    }
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailedView.toggle()
    }
}

struct AllCoinsView_Previews: PreviewProvider {
static var previews: some View {
    AllCoinsView()
        .environmentObject(dev.coinViewModel)
}
}

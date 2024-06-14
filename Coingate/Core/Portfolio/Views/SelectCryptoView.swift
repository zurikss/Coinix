//
//  SelectCryptoView.swift
//  Coingate
//
//  Created by Victor on 05/11/2023.
//

import SwiftUI

struct SelectCryptoView: View {
    
    @EnvironmentObject var viewModel: CoinsViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCoin: CoinModel? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.white000.ignoresSafeArea(.all)
                VStack(alignment: .leading, spacing: 16, content: {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 8) {
                            ForEach(viewModel.allCoins) { coin in
                                NavigationLink {
                                    AmountView(coin: coin)
                                        .ignoresSafeArea(.all)
                                } label: {
                                    PortfolioCoinRowView(coin: coin)
                                }
                                .buttonStyle(BouncyButton())
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                })
                .padding(.horizontal, 16)
                //.padding(.top, 24)
                .navigationTitle("Select crypto")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            viewModel.searchText = ""
                        }, label: {
                            DownButtonView()
                        })

                    }
            }
                .padding(.top, 24)
            }
            
            .onAppear(perform: {
                if viewModel.selectCoinDismiss {
                    presentationMode.wrappedValue.dismiss()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.selectCoinDismiss = false
                }
            })
        }

    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
    }
}

#Preview {
    SelectCryptoView()
        .environmentObject(dev.coinViewModel)
}

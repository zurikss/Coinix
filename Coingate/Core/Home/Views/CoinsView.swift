//
//  CoinsView.swift
//  Coingate
//
//  Created by Victor on 27/10/2023.
//

import SwiftUI

struct CoinsView: View {
    
    @EnvironmentObject private var viewModel: CoinsViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailedView: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24 ,content: {
            HStack(content: {
                Text("Coins")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(Color.theme.gray900)
                Spacer()
                Button {
                    HapticsManager.instance.impact(style: .soft)
                } label: {
                    NavigationLink {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            AllCoinsView()
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text("See all")
                                .font(.body)
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.gray600)
                            
                            Image("down_arrow")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.gray600)
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                                .rotationEffect(Angle(degrees: -90))
                        }
                        .foregroundStyle(Color.theme.gray900)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.theme.white100)
                        .clipShape(RoundedRectangle(cornerRadius: 32))

                    }
                }
                .buttonStyle(BouncyButton())

                
            })
                VStack(alignment: .leading, spacing: 32) {
                    if viewModel.allCoins.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(viewModel.allCoins.prefix(5)) { coin in
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
        .sheet(isPresented: $showDetailedView, onDismiss: nil, content: {
            DetailLoadingView(coin: $selectedCoin)
        })
//        .background(
//            NavigationLink(isActive: $showDetailedView, destination: {
//                DetailLoadingView(coin: $selectedCoin)
//            }, label: {
//                EmptyView()
//            })
//        )
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailedView.toggle()
    }
}




struct CoinsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsView()
            .environmentObject(dev.coinViewModel)
    }
}

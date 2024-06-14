//
//  PortfolioAssetView.swift
//  Coingate
//
//  Created by Victor on 09/11/2023.
//

import SwiftUI

struct PortfolioAssetView: View {
    
    let coin: CoinModel
    @EnvironmentObject private var coinsViewModel: CoinsViewModel
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                CoinImageaView(coin: coin)
                    .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Rectangle()
                            .frame(width: 8, height: 35, alignment: .center)
                            .blur(radius: 4)
                            .rotationEffect(Angle(degrees: 30))
                            .opacity(0.9)
                            .offset(x: coinsViewModel.coinAdded ? -27 : 27.0)
                        
                    }
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2, content: {
                    Text(coin.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .foregroundStyle(.gray900)
                    Text(coin.symbol.uppercased())
                        .font(.callout)
                        .foregroundStyle(.gray500)
                        .fontWeight(.medium)
                })
                .fontDesign(.rounded)
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .leading)
            Spacer()
            HStack(spacing: 20) {
                VStack(alignment: .trailing, spacing: 2) {
                    Text(coin.currentPrice?.asCurrencyWith2Decimals() ?? "")
                        .font(.body)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .foregroundStyle(.gray900)
                    
                    HStack(spacing: 2) {
                        Image("up")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? .green900 : .red900)
                            .rotationEffect(Angle(degrees: (coin.priceChangePercentage24H ?? 0) >= 0 ? 0 : 180))
                        Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? .green900 : .red900 )
                    }
                }
                .fontDesign(.rounded)
                
                
                VStack(alignment: .trailing, spacing: 2, content: {
                    Text ("\((coin.currentHoldings?.asCurrencyWith2Decimals() ?? ""))")
                        .font(.body)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .foregroundStyle(.gray900)
                    
                    Text(coin.currentHoldingsValue.asNumberString() + " " + (coin.symbol.uppercased()))
                        .font(.callout)
                        .foregroundStyle(.gray500)
                        .fontWeight(.medium)
                        .lineLimit(1)
                       
                })
                .frame(width: UIScreen.main.bounds.width / 4.5, alignment: .trailing)
            }
        }
        
    }
}

#Preview {
    PortfolioAssetView(coin: dev.coin)
        .environmentObject(dev.coinViewModel)
}

//
//  CoinRowView.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(spacing: 12) {
                CoinImageaView(coin: coin)
                    .frame(width: 35, height: 35, alignment: .center)
                    .foregroundStyle(Color.theme.gray100)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(coin.symbol.uppercased())
                        .font(.body)
                        .foregroundStyle(.gray900)
                        .fontWeight(.semibold)
                        .lineLimit(1)
            
                    Text(coin.marketCap?.formattedWithAbbreviations() ?? "")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray600)
                }
            }
            Spacer()
            CoinChartView(coin: coin)
                .frame(width: 76, height: 21, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(coin.currentPrice?.asCurrencyWith2Decimals() ?? "n/a")
                    .font(.body)
                    .foregroundStyle(.gray900)
                    .fontWeight(.semibold)
                HStack(spacing: 2) {
                    Image("up")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? .green900 : .red900)
                        .rotationEffect(Angle(degrees: (coin.priceChangePercentage24H ?? 0) >= 0 ? 0 : 180))
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? .green900 : .red900 )
                }
            }
            
        }
        .fontDesign(.rounded)
        .background(Color.theme.white000)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}


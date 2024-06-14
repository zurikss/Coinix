//
//  TopGainerCoinView.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import SwiftUI

struct TopGainerCoinView: View {
    let coin: CoinModel
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            CoinImageaView(coin: coin)
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundStyle(Color.theme.gray100)
                .clipShape(Circle())
            
            VStack(alignment: .leading , spacing: 8) {
                HStack(spacing: 4) {
                    Text(coin.symbol.uppercased())
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray900)
                    Circle()
                        .frame(width: 4, height: 4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.gray500)
                    Text(coin.currentPrice?.asCurrencyWith2Decimals() ?? "n/a")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray500)
                }
                
                HStack(spacing: 2) {
                    Image("up")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? .green900 : .red900)
                        .rotationEffect(Angle(degrees: (coin.priceChangePercentage24H ?? 0) >= 0 ? 0 : 180))
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? .green900 : .red900 )
                }
            }
        }
        .padding(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 2)
                .foregroundStyle(.gray100)
        }
    }
}

struct TopGainerCoinView_Previews: PreviewProvider {
    static var previews: some View {
        TopGainerCoinView(coin: dev.coin)
    
    }
}

//
//  PortfolioCoinRowView.swift
//  Coingate
//
//  Created by Victor on 05/11/2023.
//

import SwiftUI

struct PortfolioCoinRowView: View {
    
    let coin: CoinModel
    
    var body: some View {
        HStack(spacing: 12) {
            CoinImageaView(coin: coin)
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundStyle(Color.theme.gray100)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(coin.symbol.uppercased())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray900)
                
                Text(coin.currentPrice?.asCurrencyWith2Decimals() ?? "")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray500)
            }
            .fontDesign(.rounded)
            
            Spacer()
            
            Image("down_arrow")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.gray400)
                .rotationEffect(Angle(degrees: 270))
        }
        .padding(16)
        .background(.white000)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray100, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    PortfolioCoinRowView(coin: dev.coin)
}

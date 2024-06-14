//
//  StatisticView.swift
//  Coingate
//
//  Created by Victor on 31/10/2023.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(stat.image)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.gray400)
                Text(stat.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray500)
            }
            Spacer()
            Text(stat.value)
                .fontWeight(.medium)
                .foregroundStyle(.gray900)
        }
        .padding(8)
        .background(stat.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
        .fontDesign(.rounded)
    }
    
    struct StatisticView_Previews: PreviewProvider {
        static var previews: some View {
            StatisticView(stat: dev.stat1)
        }
    }
    
}

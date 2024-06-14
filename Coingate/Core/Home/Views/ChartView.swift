//
//  ChartView.swift
//  Coingate
//
//  Created by Victor on 29/10/2023.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green900 : Color.theme.red900
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    // Screen of 300 with 100 items: then 300 / 100 = 3 points
    // So this means if our index is 0 and the data calculated is 3 we will get
    // 3*(0+1) = 3
    // 3*(1+1) = 3*2 = 6 , then 9, then 300
    
    // max - 60,000
    // min = 50,000
    // 60,000 - 50,000 = yAxis
    
    var body: some View {
        VStack(spacing: 32) {
            chartView
                .frame(height: 156)
                .background(chartBackground)
            //.overlay(alignment: .leading) {chartYAxis}
            
            HStack(content: {
                Text(startingDate.asShortDateString())
                Spacer()
                Text(endingDate.asShortDateString())
            })
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.gray400)
            .padding(.horizontal, 16)
            .fontDesign(.rounded)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 1.5, dampingFraction: 1, blendDuration: 1)) {
                    percentage = 1.0
                }
            }
        })
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
            //.environmentObject(dev.newsViewModel)
    }
}


extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
        }
    }
    
    private var chartBackground: some View {
        VStack(content: {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
//            Rectangle()
//                .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
//                .frame(height: 0.24)
//                .frame(maxWidth: .infinity)
        })
        .foregroundStyle(.gray100)
    }
    
    private var chartYAxis: some View {
        VStack(content: {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        })
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.gray400)
        .fontDesign(.rounded)
    }
}

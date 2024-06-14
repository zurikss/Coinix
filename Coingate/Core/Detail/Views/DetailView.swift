//
//  DetailView.swift
//  Coingate
//
//  Created by Victor on 30/10/2023.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        if let coin = coin {
            DetailView(coin: coin)
        }
    }
}

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    //@StateObject private var coinViewModel: CoinsViewModel
    @State private var readMoreIsPressed: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        //_coinViewModel = StateObject(wrappedValue: CoinsViewModel())
    }
    
    var body: some View {
        ZStack {
            Color.theme.white000.ignoresSafeArea()
            VStack {
                HStack(content: {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        DownButtonView()
                    })
                    Spacer()
                })
                .padding(.horizontal, 16)
                .padding(.top, 24)
                ScrollView {
                    VStack(alignment: .leading, spacing: 40) {
                        VStack(alignment: .leading, spacing: 73) {
                            coinPrice
                            VStack(spacing: 32) {
                                ChartView(coin: viewModel.coin)
                                timeInterval
                            }
                        }
                        divider
                        overview
                        divider
                        stats
                        divider
                        link
                    }
                    .padding(.vertical, 32)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
            .environmentObject(dev.coinViewModel)
    }
}


extension DetailView {
    private var coinPrice: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading, spacing: 16) {
                CoinImageaView(coin: viewModel.coin)
                    .frame(width: 70, height: 70, alignment: .center)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.coin.name)
                    Text(viewModel.coin.currentPrice?.asCurrencyWith2Decimals() ?? "n/a")
                }
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.gray900)
            }
            
            Spacer()
            
            HStack(spacing: 2) {
                Image("up")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundStyle((viewModel.coin.priceChangePercentage24H ?? 0) >= 0 ? .green900 : .red900)
                    .rotationEffect(Angle(degrees: (viewModel.coin.priceChangePercentage24H ?? 0) >= 0 ? 0 : 180))
                Text(viewModel.coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle((viewModel.coin.priceChangePercentage24H ?? 0) >= 0 ? .green900 : .red900 )
            }
        }
        .padding(.horizontal, 16)
        .fontDesign(.rounded)
    }
    
    private var dateIntervalPlaceHolder: some View {
        RoundedRectangle(cornerRadius: 32)
            .frame(width: 38, height: 38)
            .foregroundStyle(.white100)
    }
    
    private var divider: some View {
        Divider()
            .background(Color.theme.gray100)
    }
    
    private var overview: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(content: {
                Image("overview")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray400)
                
                Text("Overview")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray900)
            })
            if let coinDescription = viewModel.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text(coinDescription)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray500)
                        .fontDesign(.rounded)
                        .lineLimit(readMoreIsPressed ? nil : 4)
                    
                    Button(action: {
                        withAnimation(.smooth(duration: 0.2, extraBounce: 0)) {
                            readMoreIsPressed.toggle()
                        }
                    }, label: {
                        HStack(spacing: 6) {
                            Text(readMoreIsPressed ? "Show Less" : "Read More")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray900)
                            Image("down_arrow")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray900)
                                .rotationEffect(Angle(degrees: readMoreIsPressed ? 180 : 360))
                        }
                    })
                    .buttonStyle(BouncyButton())
                }
            }
            
        }
        .padding(.horizontal, 16)
        .fontDesign(.rounded)
    }
    
    private var timeInterval: some View {
        HStack(alignment: .center, spacing: 16) {
            
            Text("Weekly chart: Trends, patterns, insights emerge.")
                .font(.caption)
                .fontWeight(.regular)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .foregroundStyle(.gray500)
                .background(.white100)
                .clipShape(RoundedRectangle(cornerRadius: 32))
            
        }
    }
    
    private var oldStat: some View {
        VStack(alignment: .leading, spacing: 48) {
            HStack(content: {
                Image("stats")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray400)
                
                Text("Stats")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray900)
            })
            VStack(alignment: .leading, spacing: 40) {
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        Text("Rank")
                            .font(.body)
                            .foregroundStyle(.gray500)
                        Text(viewModel.coin.rank.description)
                            .font(.title2)
                            .foregroundStyle(.gray900)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        Text("Market Cap")
                            .font(.body)
                            .foregroundStyle(.gray500)
                        Text(viewModel.coin.marketCap?.formattedWithAbbreviations() ?? "")
                            .font(.title2)
                            .foregroundStyle(.gray900)
                    }
                    Spacer()
                }
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        HStack(spacing: 8) {
                            Image("market_cap")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray400)
                            Text("24h Market Cap Change")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray500)
                        }
                        Spacer()
                        Text(viewModel.coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
                            .fontWeight(.medium)
                            .foregroundStyle(.gray900)
                    }
                    .padding(8)
                    .background(Color.theme.gray100)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    HStack {
                        HStack(spacing: 8) {
                            Image("price_change")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray400)
                            Text("24h Price Change")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray500)
                        }
                        Spacer()
                        Text(viewModel.coin.priceChangePercentage24HInCurrency?.formattedWithAbbreviations() ?? "")
                            .fontWeight(.medium)
                            .foregroundStyle(.gray900)
                    }
                    .padding(8)
                    .background(Color.theme.white000)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    HStack {
                        HStack(spacing: 8) {
                            Image("price_high")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray400)
                            Text("24h Price High")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray500)
                        }
                        Spacer()
                        Text(viewModel.coin.high24H?.formattedWithAbbreviations() ?? "")
                            .fontWeight(.medium)
                            .foregroundStyle(.gray900)
                    }
                    .padding(8)
                    .background(Color.theme.gray100)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    HStack {
                        HStack(spacing: 8) {
                            Image("price_low")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray400)
                            Text("24h Price Low")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray500)
                        }
                        Spacer()
                        Text(viewModel.coin.low24H?.formattedWithAbbreviations() ?? "")
                            .fontWeight(.medium)
                            .foregroundStyle(.gray900)
                    }
                    .padding(8)
                    .background(Color.theme.white000)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    HStack {
                        HStack(spacing: 8) {
                            Image("clock")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray400)
                            Text("Block Time")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray500)
                        }
                        Spacer()
                        Text(viewModel.coin.high24H?.formattedWithAbbreviations() ?? "")
                            .fontWeight(.medium)
                            .foregroundStyle(.gray900)
                    }
                    .padding(8)
                    .background(Color.theme.gray100)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    HStack {
                        HStack(spacing: 8) {
                            Image("print")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray400)
                            Text("Hashing Algorithm")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray500)
                        }
                        Spacer()
                        Text(viewModel.coin.low24H?.formattedWithAbbreviations() ?? "")
                            .fontWeight(.medium)
                            .foregroundStyle(.gray900)
                    }
                    .padding(8)
                    .background(Color.theme.white000)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                }
            }
            
        }
        .padding(.horizontal, 16)
        .fontDesign(.rounded)
    }
    
    private var stats: some View {
        VStack(alignment: .leading, spacing: 48) {
            HStack(content: {
                Image("layers")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray400)
                
                Text("Stats")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray900)
            })
            .padding(.horizontal, 16)
            
            VStack(alignment: .leading, spacing: 40) {
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        Text("Rank")
                            .font(.body)
                            .foregroundStyle(.gray500)
                        Text(viewModel.coin.rank.description)
                            .font(.title2)
                            .foregroundStyle(.gray900)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        Text("Market Cap")
                            .font(.body)
                            .foregroundStyle(.gray500)
                        Text(viewModel.coin.marketCap?.formattedWithAbbreviations() ?? "")
                            .font(.title2)
                            .foregroundStyle(.gray900)
                    }
                    Spacer()
                }
                .fontDesign(.rounded)
                .fontWeight(.semibold)

                VStack(spacing: 0) {
                    ForEach(viewModel.additionalStatistics) { stat in
                        StatisticView(stat: stat)
                    }
                }
            }
        }
    }
    
    private var link: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(content: {
                Image("link")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray400)
                
                Text("Link")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray900)
            })
            
            
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    if let websiteString = viewModel.coinWebsiteURL,
                        let url = URL(string: websiteString) {
                        Link(destination: url, label: {
                            HStack(spacing: 8){
                                Image("world")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(.gray400)
                                
                                Text("Website")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.gray900)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.theme.white100)
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                        })
                        .buttonStyle(BouncyButton())
                    }
                    
                    if let redditString = viewModel.coinRedditURL,
                        let url = URL(string: redditString) {
                        Link(destination: url, label: {
                            HStack(spacing: 8){
                                Image("reddit_pro")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(.gray400)
                                
                                Text("Reddit")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.gray900)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.theme.white100)
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                        })
                        .buttonStyle(BouncyButton())
                    }
                    
                    GridRow {
                        if let twitterString = viewModel.coinTwitterURL,
                            let url = URL(string: twitterString) {
                            Link(destination: url, label: {
                                HStack(spacing: 8){
                                    Image("twitter")
                                        .resizable()
                                        .renderingMode(.template)
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(.gray400)
                                    
                                    Text("X")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                        .foregroundStyle(.gray900)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.theme.white100)
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                            })
                            .buttonStyle(BouncyButton())
                        }
                    }
                }

                    if let facebookString = viewModel.coinFacebookURL,
                        let url = URL(string: facebookString) {
                        Link(destination: url, label: {
                            HStack(spacing: 8){
                                Image("facebook")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(.gray400)
                                
                                Text("Facebook")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.gray900)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.theme.white100)
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                        })
                        .buttonStyle(BouncyButton())
                    }
            }
        }
        .padding(.horizontal, 16)
    }
}

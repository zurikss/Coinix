//
//  DetailViewModel.swift
//  Coingate
//
//  Created by Victor on 30/10/2023.
//

import Foundation
import Combine
import SwiftUI

class DetailViewModel: ObservableObject {
    
    @Published var coin: CoinModel
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var coinWebsiteURL: String? = nil
    @Published var coinRedditURL: String? = nil
    @Published var coinTwitterURL: String? = nil
    @Published var coinFacebookURL: String? = nil

    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
        self.subscribeToDetailService()
    }
    
    private func subscribeToDetailService() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArray in
                self?.overviewStatistics = returnedArray.overview
                self?.additionalStatistics = returnedArray.additional
                print("returned coin details")
                //print(returnedCoinDetails)
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetail
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.coinWebsiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.coinRedditURL = returnedCoinDetails?.links?.subredditURL
                self?.coinTwitterURL = returnedCoinDetails?.links?.twitterScreenName
                self?.coinFacebookURL = returnedCoinDetails?.links?.facebookUsername
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        
        let overviewArray =  createOverviewArray(coinModel: coinModel)
        let additionalArray = additionalOverviewArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        // overview
        let price = coinModel.currentPrice?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", image: "", value: price, background: Color.theme.white000, percentageChange: pricePercentChange)
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", image: "market_cap", value: marketCap, background: Color.theme.white000, percentageChange:
        marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", image: "", value: rank, background: Color.theme.white000)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", image: "", value: volume, background: Color.theme.white000)
        
        let overviewArray: [StatisticModel] = [
        priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overviewArray
    }
    
    private func additionalOverviewArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticModel] {
        // additional
        let high = coinModel.high24H?.asCurrencyWith2Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h Price High", image: "price_high", value: high, background: Color.theme.white100)
        
        let low = coinModel.low24H?.asCurrencyWith2Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Price Low", image: "price_low", value: low, background: Color.theme.white000)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", image: "price_change", value: priceChange, background: Color.theme.white000, percentageChange: pricePercentChange2)
                                             
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", image: "market_cap", value: marketCapChange, background: Color.theme.white100, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", image: "clock", value: blockTimeString, background: Color.theme.white100)
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", image: "print", value: hashing, background: Color.theme.white000)
                                             
        let additionalArray: [StatisticModel] = [ marketCapChangeStat, priceChangeStat,
            highStat, lowStat, blockStat, hashingStat
        ]
        return additionalArray
    }
    
}

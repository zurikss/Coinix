//
//  CoinDetailService.swift
//  Coingate
//
//  Created by Victor on 30/10/2023.
//

import Foundation
import Combine

class CoinDetailService {
    @Published var coinDetail: CoinDetailModel? = nil
    let coin: CoinModel
    
    var coinDetailSubscription: AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        downloadCoinDetails()
    }
    
    private func downloadCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleSinkCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetail = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
    
    private func handleTryMapOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

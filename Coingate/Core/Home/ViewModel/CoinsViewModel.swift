//
//  CoinsViewModel.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import Foundation
import Combine

class CoinsViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var sortedGainersCoins: [CoinModel] = []
    @Published var sortedLosersCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var selectCoinDismiss: Bool = false
    @Published var isLoading: Bool = false
    @Published var coinAdded: Bool = false

    
    
    private let dataService = CoinDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        self.isLoading = true
        //self.portfolioCoins.append(DeveloperPreview.instance.coin)
    }
    
    func addSubscribers() {
        
        // updates allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filteredCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.sortedGainersCoins = returnedCoins.sorted(by: {$0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0})
                self?.sortedLosersCoins = returnedCoins.sorted(by: {$0.priceChangePercentage24H ?? 0 < $1.priceChangePercentage24H ?? 0})
            }
            .store(in: &cancellables)
        
        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        dataService.downloadCoins()
        HapticsManager.instance.notification(type: .success)
    }
    
//    func updateProfile(profile: String) {
//        portfolioDataService.addProfile(profile: profile)
//    }
    
    private func filteredCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowerCaseText = text.lowercased()
        let filteredCoins = coins.filter { coin in
            return coin.name.lowercased().contains(lowerCaseText) || coin.symbol.lowercased().contains(lowerCaseText) || coin.id.lowercased().contains(lowerCaseText)
        }
        return filteredCoins

    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel] , portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                return nil
            }
                return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    var totalHoldingsValue: Double {
        // Assuming you have an array of CoinModel instances named "coinModels"
        let holdingsValues = portfolioCoins.map { $0.currentHoldings ?? 0 }
        return holdingsValues.reduce(0, +)
    }
    
    
}

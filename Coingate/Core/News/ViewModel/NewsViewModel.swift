//
//  NewsViewModel.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var news: [NewsModel] = []
    
    private let dataService = NewsDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$news
            .sink { [weak self] returnedNews in
                self?.news = returnedNews
            }
            .store(in: &cancellables)

    }
    
}

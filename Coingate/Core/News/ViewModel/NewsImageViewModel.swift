//
//  NewsImageViewModel.swift
//  Coingate
//
//  Created by Victor on 29/10/2023.
//

import Foundation
import SwiftUI
import Combine

class NewsImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let news: NewsModel
    private let dataService: NewsImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(news: NewsModel) {
        self.news = news
        self.dataService = NewsImageService(news: news)
        self.subscribeToDataService()
        self.isLoading = true
    }
    
    private func subscribeToDataService() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
    
}

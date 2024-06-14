//
//  NewsDataService.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import Foundation
import Combine

class NewsDataService {
    @Published var news: [NewsModel] = []
    
    var newsSubscription: AnyCancellable?
    
    init() {
        downloadNews()
    }
    
    private func downloadNews() {
        guard let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_317905b5bb6ac6f2d9c3687259019ad93ce26&q=bitcoin&language=en") else { return }
        newsSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleTryMapOutput)
            .decode(type: NewsData.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Data downloaded")
                    break
                case .failure(let error):
                    print("Error downloading news data: \(error)")
                }
            } receiveValue: { [weak self] newsData in
                self?.news = newsData.results
            }
    }
    
    private func handleTryMapOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct NewsData: Codable {
    let results: [NewsModel]
}

//
//  NetworkingManager.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import Foundation
import Combine

class NetworkingManager {

    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        // variable inside an enum
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🥲] Bad response from URL. \(url)"
            case .unknown: return "[🫣] Unknown error occured"
            }
        }
    }

    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap({ try handleTryMapOutput(output: $0, url: url )})
            .eraseToAnyPublisher()
        
        
        func handleTryMapOutput(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
            guard let response = output.response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                throw NetworkingError.badURLResponse(url: url)
            }
            return output.data
        }
        
    }
    
    static func handleSinkCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("Data downloaded")
            break
        case .failure(let error):
            print("Error downloading data: \(error)")
        }
    }
}

//
//  NewsImageService.swift
//  Coingate
//
//  Created by Victor on 29/10/2023.
//

import Foundation
import SwiftUI
import Combine

class NewsImageService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let news: NewsModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coun_images"
    private let imageName: String
    
    init(news: NewsModel) {
        self.news = news
        self.imageName = news.articleID ?? ""
        getCoinImageFromFM()
    }
    
    private func getCoinImageFromFM() {
        if let savedImage = fileManager.getImage(imageName: news.articleID ?? "", folderName: folderName) {
            image = savedImage
            print("Retrieved Image from File Manager")
        } else {
            downloadCoinImage()
            print("Dowloading Images Now")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: news.imageURL ?? "") else { return }
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleSinkCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}

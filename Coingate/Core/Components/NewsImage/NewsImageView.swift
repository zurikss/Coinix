//
//  NewsImageView.swift
//  Coingate
//
//  Created by Victor on 29/10/2023.
//

import SwiftUI

struct NewsImageView: View {
    
    @StateObject var viewModel: NewsImageViewModel
    
    init(news: NewsModel) {
        _viewModel = StateObject(wrappedValue: NewsImageViewModel(news: news))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if viewModel.isLoading {
                Image("bitcoin")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image(systemName: "questionmark")
            }
        }
    }
}

struct NewsImageView_Previews: PreviewProvider {
    static var previews: some View {
        NewsImageView(news: dev.news)
    }
}

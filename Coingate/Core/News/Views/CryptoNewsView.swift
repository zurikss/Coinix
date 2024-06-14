//
//  CryptoNewsView.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import SwiftUI

struct CryptoNewsView: View {
    
    @StateObject var viewModel = NewsViewModel()
    let news: NewsModel
    @State private var selectedNews: NewsModel? = nil
    @State private var goToDetailView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.white000.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Crypto News")
                            .font(.title2)
                            .fontWeight(.semibold)
                        .foregroundStyle(Color.theme.gray900)
                        
                        Spacer()
                    }
                    
                    if viewModel.news.isEmpty {
                        ProgressView()
                        //NoNewsView()
                    } else {
                        ScrollView {
                            VStack(alignment: .center, spacing: 16) {
                                ForEach(viewModel.news, id: \.self) { news in
                                    NavigationLink {
                                        DetailedNewsView(news: news)
                                            //.padding(.top, -1)
                                    } label: {
                                        SingleNewsView(news: news)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            .fontDesign(.rounded)
            }
        }
    }
}

struct CryptoNewsView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoNewsView(news: dev.news)
            .environmentObject(dev.newsViewModel)
    }
}

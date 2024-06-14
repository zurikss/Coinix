//
//  SingleNewsView.swift
//  Coingate
//
//  Created by Victor on 28/10/2023.
//

import SwiftUI

struct SingleNewsView: View {
    
    let news: NewsModel
    @EnvironmentObject var viewModel: NewsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            VStack(alignment: .leading, spacing: 16, content: {
                HStack(content: {
                    Text((news.sourceID ?? "").uppercased())
                    Spacer()
                    Text((news.pubDate?.asFormattedDate() ?? "").uppercased())
                })
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.gray600)
                
                HStack(alignment: .top, content: {
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text(news.title ?? "")
                            .font(.title3)
                            .foregroundStyle(.gray900)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        
                        Text(news.description ?? "")
                            .font(.body)
                            .foregroundStyle(.gray600)
                            .fontWeight(.regular)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                    })
                    Spacer()
                    NewsImageView(news: news)
                        .frame(width: 95, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                })
            })
        })
        .padding(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 2.0)
                .foregroundStyle(.gray100)
        }

    }
}


struct SingleNewsView_Previews: PreviewProvider {
    static var previews: some View {
        SingleNewsView(news: dev.news)
            .environmentObject(dev.newsViewModel)
    }
}

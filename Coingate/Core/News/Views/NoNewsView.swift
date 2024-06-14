//
//  NoNewsView.swift
//  Coingate
//
//  Created by Victor on 19/12/2023.
//

import SwiftUI

struct NoNewsView: View {
    @State private var test: Bool = false
    var body: some View {
            VStack(alignment: .center, spacing: 16, content: {
                ProgressView()
                    .progressViewStyle(.circular)
                HStack(alignment: .top, content: {
                    VStack(alignment: .center, spacing: 8, content: {
                        Text("Apologies, news is on its way! ")
                            .font(.title3)
                            .foregroundStyle(.gray900)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                        
                        Text("A brief delay, but we'll have it for you soon. 📰✨")
                            .font(.body)
                            .foregroundStyle(.gray600)
                            .fontWeight(.regular)
                            .lineLimit(3)
                            .multilineTextAlignment(.center)
                    })
                })
            })
        .padding(.horizontal, 48)
        .padding(.vertical, 32)
        .background(.gray50)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .onTapGesture {
            test.toggle()
        }
        .shake($test)
    }
}

#Preview {
    NoNewsView()
}

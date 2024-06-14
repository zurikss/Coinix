//
//  CoinImageaView.swift
//  Coingate
//
//  Created by Victor on 29/10/2023.
//

import SwiftUI

struct CoinImageaView: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
            }
        }
    }
}


struct CoinImageaView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageaView(coin: dev.coin)
    }
}

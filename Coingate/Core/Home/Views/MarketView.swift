//
//  MarketView.swift
//  Coingate
//
//  Created by Victor on 27/10/2023.
//

import SwiftUI

struct MarketView: View {
    
    @EnvironmentObject private var coinViewModel: CoinsViewModel
    @EnvironmentObject private var newsViewModel: NewsViewModel
    @EnvironmentObject private var sheetManager: SheetManager
    @EnvironmentObject var viewModel: PortfolioViewModel
    @EnvironmentObject private var settingsViewModel: SettingsViewModel
    @EnvironmentObject private var modeSheetManager: ModeSheetManager


    
    var body: some View {
        TabView {
            marketData
            //Text("")
            .tabItem {
                Image("market")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("Market")
                    .fontDesign(.rounded)
            }
            PortfolioView(coin: dev.coin)
            .tabItem {
                Image("portfolio")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text("Portfolio")
                    .fontDesign(.rounded)
            }
            SettingsView()
            .tabItem {
                Image("settings-2")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    
                Text("Settings")
                    .fontDesign(.rounded)
            }
            
        }
        .tint(.gray900)
        .overlay(alignment: .bottom) {
            if sheetManager.action.isPresented {
                Color(.black.opacity(0.5))
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.spring) {
                            sheetManager.dismiss()
                        }
                        
                    }
                
                LayerExample {
                    sheetManager.dismiss()
                }
                .transition(.asymmetric(insertion: .move(edge: .bottom).animation(.spring(response: 0.4, dampingFraction: 0.9, blendDuration: 1)), removal: .move(edge: .bottom).animation(.spring(response: 1, dampingFraction: 1, blendDuration: 1))))
                
            }
        }
        
        .overlay(alignment: .bottom) {
            if modeSheetManager.action.isPresented {
                Color(.black.opacity(0.5))
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.spring) {
                            modeSheetManager.dismiss()
                        }
                        
                    }
                
                ThemesCompView {
                    modeSheetManager.dismiss()
                }
                .transition(.asymmetric(insertion: .move(edge: .bottom).animation(.spring(response: 0.4, dampingFraction: 0.9, blendDuration: 1)), removal: .move(edge: .bottom).animation(.spring(response: 1, dampingFraction: 1, blendDuration: 1))))
                
            }
        }
        
        .onAppear(perform: {
            coinViewModel.searchText = ""
        })
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
            .environmentObject(dev.coinViewModel)
            .environmentObject(dev.newsViewModel)
            .environmentObject(SheetManager())
            .environmentObject(PortfolioViewModel())
            .environmentObject(SettingsViewModel())
            .environmentObject(ModeSheetManager())

        
    }
}

extension MarketView {
    private var marketData: some View {
        NavigationStack {
            ZStack {
                Color.theme.white000.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 40, content: {
                        CoinsView()
                        Divider()
                            .background(Color.theme.gray200)
                        TopGainersView(coin: DeveloperPreview.instance.coin)
                        Divider()
                            .background(Color.theme.gray200)
                        TopLosersView(coin: DeveloperPreview.instance.coin)
                        Divider()
                            .background(Color.theme.gray200)
                        CryptoNewsView(news: dev.news)
                        
                        
                    })
                    .padding(.top, 16)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                SearchView()
                            } label: {
                                Image("search")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundStyle(Color.theme.gray900)
                            }

                            
                        }
                    }
                }
                .refreshable {
                    coinViewModel.reloadData()
                }
            }
            .navigationTitle("Market")
        }
    }
}

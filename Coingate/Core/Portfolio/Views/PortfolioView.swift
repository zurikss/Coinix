//
//  PortfolioView.swift
//  Coingate
//
//  Created by Victor on 01/11/2023.
//

import SwiftUI


struct PortfolioView: View {
    
    let coin: CoinModel
    @EnvironmentObject private var sheetManager: SheetManager
    @EnvironmentObject private var viewModel: PortfolioViewModel
    @EnvironmentObject private var coinsViewModel: CoinsViewModel
    @EnvironmentObject private var settingsViewModel: SettingsViewModel

    @State private var showSelectView: Bool = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    Color.theme.white000.ignoresSafeArea()
                    ScrollView {
                        VStack(alignment: .center, spacing: 40, content: {
                            VStack(alignment: .center, spacing: 12, content: {
                                profile
                                totalValue
                                Text(settingsViewModel.isOn == false && coinsViewModel.totalHoldingsValue.asCurrencyWith2Decimals().isEmpty ? "$0.00" : settingsViewModel.hideBalance ? settingsViewModel.balanceIcon : "\(coinsViewModel.totalHoldingsValue.asCurrencyWith2Decimals())")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.gray900)
                            })
                            .onLongPressGesture {
                                
                            }
                            Divider()
                            
                            VStack(alignment: .center, spacing: 24) {
                                HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                                    Text("Your assets")
                                        .font(.title2)
                                        .foregroundStyle(.gray900)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                    Spacer()
                                    
                                })
                                if coinsViewModel.portfolioCoins.isEmpty {
                                    emptyState
                                } else {
                                    allAssets
                                }
                        
                                    
                            }
                            .padding(.horizontal, 16)
                        })
                        .padding(.vertical, 32)
                    }
                    
                }
                //.zIndex(0)
                
                Button {
                    showSelectView.toggle()
                    HapticsManager.instance.impact(style: .soft)
                } label: {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.white000)
                        .scaledToFit()
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(20)
                        .background(Color.theme.gray900)
                        .clipShape(Circle())
                        .padding(16)
                }
                .buttonStyle(BouncyButton())
                
            }
            .navigationTitle("Portfolio")
            .onAppear(perform: {
                coinsViewModel.searchText = ""
            })
        }
        .sheet(isPresented: $showSelectView, onDismiss: nil) {
            SelectCryptoView()
                .ignoresSafeArea(.all)
                
        }
        
//        .overlay(alignment: .bottom) {
//            if sheetManager.action.isPresented {
//                Color(.black.opacity(0.25))
//                    .ignoresSafeArea()
//                
//                LayerExample{
//                    sheetManager.dismiss()
//                }
//                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
//                
//            }
//        }
    }
}

#Preview {
    PortfolioView(coin: dev.coin)
        .environmentObject(SheetManager())
        .environmentObject(PortfolioViewModel())
        .environmentObject(CoinsViewModel())
        .environmentObject(SettingsViewModel())
}

extension PortfolioView {
    private var profile: some View {
        Button(action: {
            withAnimation(.spring(response: 0.38, dampingFraction: 0.88, blendDuration: 1)) {
                sheetManager.present()
            }
            HapticsManager.instance.impact(style: .soft)
        }, label: {
            
            if !viewModel.portfolioTextProfile.isEmpty {
                Text(viewModel.portfolioTextProfile)
                    .font(.title)
                    .padding(.horizontal, 21)
                    .padding(.vertical, 18)
                    .background(Color.yellow.opacity(0.5))
                    .clipShape(Circle())
                    
            } else if !viewModel.portfolioIconProfile.isEmpty {
                Image(viewModel.portfolioIconProfile)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(21)
                    .background(Color.theme.gray100)
                    .clipShape(Circle())

            } else if !viewModel.portfolioImageProfile.isEmpty {
                Image(viewModel.portfolioImageProfile)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            
            else {
                Image("placeholder_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
        })
        .overlay(alignment: .bottomTrailing) {
            Image("edit")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 16, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.gray500)
                .padding(2)
                .background(Color.theme.white100)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.white000)
                }
        }

    }
    
    private var totalValue: some View {
        HStack(spacing: 8, content: {
            Text("Total balance")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.gray500)
                .fontDesign(.rounded)
            if settingsViewModel.isOn {
                Image(settingsViewModel.hideBalance ? "eye-off" : "eyee")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.gray500)
                    .scaledToFit()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(settingsViewModel.balanceIcon.isEmpty ? 0.6 : 1)
                    .onTapGesture {
                        HapticsManager.instance.impact(style: .rigid)
                        settingsViewModel.hideBalance.toggle()
                        settingsViewModel.saveHideBalance()
                    }
                    .disabled(settingsViewModel.isOn == false)
            }
            
        })

    }
    
    private var emptyState: some View {
        VStack(alignment: .center, spacing: 24, content: {
            Image("illustration")
                .resizable()
                .scaledToFit()
                .frame(width: 175, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .center, spacing: 8) {
                Text("Nothing to show here yet")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray900)
                Text("All your assets will show here")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray500)
            }
            .fontDesign(.rounded)
        })
        .padding(.vertical, 24)

    }
    
    private var allAssets: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Coins")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .leading)
                Spacer()
                HStack(alignment: .center, spacing: 20, content: {
                    Text("Price")
                    Text("Holdings")
                        .frame(width: UIScreen.main.bounds.width / 4.5, alignment: .trailing)
                })
            }
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundStyle(.gray500)
            .fontDesign(.rounded)

            VStack(alignment: .leading, spacing: 24) {
                ForEach(coinsViewModel.portfolioCoins) { coin in
                    PortfolioAssetView(coin: coin)
                }
            }
        }
        .padding(16)
        .background(.white100)
        .clipShape(RoundedRectangle(cornerRadius: 24))

    }
}

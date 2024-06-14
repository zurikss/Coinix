//
//  AmountView.swift
//  Coingate
//
//  Created by Victor on 06/11/2023.
//

import SwiftUI

struct AmountView: View {
    
    enum AmountField: Hashable {
    case amount
    }
    
    let coin: CoinModel?
    @FocusState private var focusOnAmount: AmountField?
    @EnvironmentObject private var coinsViewModel: CoinsViewModel
    @State var quantityText: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCoin: CoinModel? = nil
    
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .top) {
                Color.theme.white000.ignoresSafeArea(.all)
                ZStack(content: {
                    VStack {
                        Spacer()
                        VStack {
                            VStack(alignment: .center, spacing: 24) {
                                
                                HStack(alignment: .center, spacing: 12, content: {
                                    CoinImageaView(coin: coin ?? dev.coin)
                                        .frame(width: 24, height: 24, alignment: .center)
                                        .clipShape(Circle())
                                    
                                    Text(coin?.symbol.uppercased() ?? "")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                })
                                .padding(12)
                                .background(Color.theme.gray100)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                VStack(alignment: .center, spacing: 16) {
                                    TextField(text: $quantityText) {
                                            Text("$0")
                                                .foregroundStyle(.gray400)
                                                .keyboardType(.numberPad)
                                        }
                                        .keyboardType(.decimalPad)
                                        .focused($focusOnAmount, equals: .amount)
                                        .submitLabel(.done)
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 72, weight: .bold, design: .rounded))
                                        .minimumScaleFactor(0.2)
                                        .frame(height: 90)
                                        .onSubmit({
                                            addCoin()
                                            quantityText = ""
                                            presentationMode.wrappedValue.dismiss()
                                            coinsViewModel.selectCoinDismiss.toggle()
                                        })
                                        .onChange(of: quantityText, { oldValue, newValue in
                                        // Remove non-numeric characters and format with commas
                                        let filteredText = newValue.filter { "0123456789.".contains($0) }
                                        if let number = Double(filteredText) {
                                            let formatter = NumberFormatter()
                                            formatter.numberStyle = .decimal
                                            if let formattedAmount = formatter.string(from: NSNumber(value: number)) {
                                                quantityText = ("$" + formattedAmount)
                                            }
                                        } else {
                                            // Handle invalid input if necessary
                                        }
                                    })
                                    Text(verbatim: "\(getCurrentAmount().asCurrencyWith5Decimals()) " + (coin?.symbol ?? "").uppercased())
                                        .foregroundStyle(.gray400)
                                        .font(.title3)
                                        .fontWeight(.semibold)


                                        
                                }
                                .padding(.horizontal, 16)
                                .onAppear(perform: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        focusOnAmount = .amount
                                        
                                    }
                            })
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                })
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addCoin()
                            quantityText = ""
                            presentationMode.wrappedValue.dismiss()
                            coinsViewModel.selectCoinDismiss.toggle()
                            print("add was pressed")
                            HapticsManager.instance.impact(style: .soft)
                        } label: {
                            Text("Add")
                                .font(.body)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white000)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(.gray900)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                        }
                        .buttonStyle(BouncyButton())

                    }
            }
                ZStack(content: {
                    richLimitReached
                    ritualistLimitReached
                    insaneLimitReached
                })
                .padding(.top, 64)
                
            }
        }
    }
    
    private func getCurrentAmount() -> Double {
        var cleanedAmount = quantityText
        cleanedAmount = cleanedAmount.replacingOccurrences(of: ",", with: "") // Replace commas with an empty string
        cleanedAmount = cleanedAmount.replacingOccurrences(of: "$", with: "") // Replace spaces with an empty string
        // You can add more replacements as needed

        if let quantity = Double(cleanedAmount) {
            return quantity / (coin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func addCoin() {
        
        var cleanedAmount = quantityText
        cleanedAmount = cleanedAmount.replacingOccurrences(of: ",", with: "") // Replace commas with an empty string
        cleanedAmount = cleanedAmount.replacingOccurrences(of: "$", with: "") //
        
            guard let coin = coin, let amount = Double(cleanedAmount) else {
                print("Selected \(coin ?? dev.coin) is nil or amount is invalid.")
                print("This is the current \(String(describing: Double(quantityText)))")
                return
            }
        
        coinsViewModel.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                coinsViewModel.coinAdded = true
            }
            
        }
        
        
            print("\(coin) and \(amount) added to portfolio")
            UIApplication.shared.endEditing()
        }
}

#Preview {
    AmountView(coin: dev.coin)
        .environmentObject(dev.coinViewModel)
}


extension AmountView {
    private var richLimitReached: some View {
        Text("Wow, you're a millionaire. 😳")
                .font(.body)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundStyle(.gray500)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(.gray100)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .scaleEffect((quantityText.count == 10 ? 1 : 0.5), anchor: .top)
                .opacity(quantityText.count == 10 ? 1 : 0)
                .animation(.spring(response: 0.25, dampingFraction: 0.7), value: quantityText)
                .multilineTextAlignment(.center)
                .padding(.vertical, 24)
    }
    
    private var ritualistLimitReached: some View {
        Text("You're a billionaire! 😱")
                .font(.title3)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundStyle(.gray500)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(.gray100)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .scaleEffect((quantityText.count == 14 ? 1 : 0.5), anchor: .top)
                .opacity(quantityText.count == 14 ? 1 : 0)
                .animation(.spring(response: 0.25, dampingFraction: 0.7), value: quantityText)
                .multilineTextAlignment(.center)
                .padding(.vertical, 24)
    }
    
    private var insaneLimitReached: some View {
        Text("DUDE WTF!!! 😭")
                .font(.title2)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundStyle(.gray500)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(.gray100)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .scaleEffect((quantityText.count > 18 ? 1 : 0.5), anchor: .top)
                .opacity(quantityText.count > 18 ? 1 : 0)
                .animation(.spring(response: 0.25, dampingFraction: 0.3), value: quantityText)
                .multilineTextAlignment(.center)
                .padding(.vertical, 24)
    }
    
//    private func addCoin() {
//        guard
//            let coin = selectedCoin,
//            let amount = Double(quantityText)
//        else { return }
//        
//        coinsViewModel.updatePortfolio(coin: coin, amount: amount)
//        print("\(coin) and \(amount) added to portfolio" )
//        
//        UIApplication.shared.endEditing()
//    }
    

}

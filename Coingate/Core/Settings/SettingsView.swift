//
//  SettingsView.swift
//  Coingate
//
//  Created by Victor on 01/11/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var modeSheetManager: ModeSheetManager
    @EnvironmentObject var viewModel: SettingsViewModel
    @State private var showSheet: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            Form(content: {
                Section("Appearance") {
                    List {
                        HStack {
                            Text("Appearance")
                            Spacer()
                            Image("arrow-ios-up")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray400)
                                .rotationEffect(Angle(degrees: 90))
                        }
                        .onTapGesture {
                            withAnimation(.spring(response: 0.38, dampingFraction: 0.88, blendDuration: 1)) {
                                modeSheetManager.present()
                            }
                        }
                    }
                    .font(.body)
                    .fontDesign(.rounded)
                    .fontWeight(.regular)
                    .foregroundStyle(.gray900)
                }
                
                Section("Balance") {
                    List {
                        Toggle(isOn: $viewModel.isOn.animation(), label: {
                            Text("Hide Total Balance")
                        })
                        .onTapGesture {
                            //viewModel.balanceIcon = ""
                            viewModel.selectedFace = ""
                            viewModel.hideBalance = false
                        }
    
                        if viewModel.isOn {
                            HStack {
                                Text("Using")
                                Spacer()
                                Text(viewModel.balanceIcon)
                                    .foregroundStyle(.gray500)
                            }
                            .opacity(viewModel.isOn ? 1 : 0.6)
                            .animation(.easeIn(duration: 0.4), value: viewModel.isOn)
//                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                            //
                            .onTapGesture {
                                showSheet = true
                            }
                            .disabled(viewModel.isOn == false)
                        }

                            
                    }
                    .font(.body)
                    .fontDesign(.rounded)
                    .fontWeight(.regular)
                    .foregroundStyle(.gray900)
                }
                
                Section("More options") {
                    List {
                        Text("About CoinGecko")
                    }
                    .font(.body)
                    .fontDesign(.rounded)
                    .fontWeight(.regular)
                    .foregroundStyle(.gray900)
                }
            })
            .navigationTitle("Settings")
            .sheet(isPresented: $showSheet, content: {
                HideBalanceView()
            })
            
            /*
             .toolbar {
                 ToolbarItem(placement: .topBarLeading) {
                     Text("Settings")
                         .fontDesign(.rounded)
                         .font(.largeTitle)
                         .fontWeight(.semibold)
                         .foregroundStyle(Color.theme.gray900)
                 }
             }
             */

        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
        .environmentObject(SheetManager())
        .environmentObject(ModeSheetManager())
}

//
//  HideBalanceView.swift
//  Coingate
//
//  Created by Victor on 13/11/2023.
//

import SwiftUI

struct HideBalanceView: View {
    
    @EnvironmentObject var viewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.facesArray, id: \.self ,content: { face in
                    HStack {
                        Text(face)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray900)
                            .fontDesign(.rounded)
                        Spacer()
                        if viewModel.selectedFace == face {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                        }
                        
                    }
                    .padding(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.theme.gray100, lineWidth: 1.0)
                    }
                    .padding(.horizontal, 16)
                    .background(.white000)
                    .onTapGesture {
                        viewModel.selectedFace = face
                    }
                })
                .padding(.top, 16)
            }
            .background(.white000)

            .navigationTitle("Using")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    DownButtonView()
                        .scaleEffect(0.8)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Text("Save")
                        .font(.body)
                        .fontDesign(.rounded)
                        .foregroundStyle(.white000)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(.gray900)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .onTapGesture {
                            viewModel.balanceIcon = viewModel.selectedFace
                            HapticsManager.instance.impact(style: .soft)
                            presentationMode.wrappedValue.dismiss()
                            viewModel.saveToUserDefaults()
                        }
                }
        })
        }
    }
}

#Preview {
    HideBalanceView()
        .environmentObject(SettingsViewModel())
}

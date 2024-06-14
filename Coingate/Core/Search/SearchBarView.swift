//
//  SearchBarView.swift
//  Coingate
//
//  Created by Victor on 05/11/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image("search")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.gray400)
            
            TextField(text: $searchText) {
                Text("Search for coins")
                    .foregroundStyle(.gray400)
            }
            .font(.body)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .overlay(alignment: .trailing) {
                Image(systemName: "xmark.circle.fill")
                    .padding(.top)
                    .padding(.bottom)
                    .padding(.leading)
                    .padding(.horizontal, -12)
                    .foregroundStyle(.accent)
                    .font(.headline)
                    .opacity(searchText.isEmpty ? 0 : 0.8)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
            }
            .autocorrectionDisabled()
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .background(Color.theme.gray50)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}

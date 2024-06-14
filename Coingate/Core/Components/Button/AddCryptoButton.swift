//
//  AddCryptoButton.swift
//  Coingate
//
//  Created by Victor on 08/11/2023.
//

import SwiftUI

struct AddCryptoButton: View {
    var body: some View {
        Text("Add")
            .font(.body)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .foregroundStyle(.white000)
            .padding(.vertical, 19)
            .frame(maxWidth: .infinity)
            .background(
              LinearGradient(
                stops: [
                    Gradient.Stop(color: .primaryButton.opacity(0.9), location: 0.00),
                    Gradient.Stop(color: .primaryButton, location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
              )
            )
            .overlay(content: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [.white.opacity(0.5), .clear],
                            startPoint: UnitPoint(x: 0.5, y: 0.02),
                            endPoint: UnitPoint(x: 0.5, y: 0.1)))
                    .cornerRadius(16)
            })
            .shadow(color: .gray200.opacity(0.1), radius: 3.5, x: 0, y: 3)
            .overlay(
              RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.25)
                .stroke(.gray900, lineWidth: 0.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    AddCryptoButton()
}

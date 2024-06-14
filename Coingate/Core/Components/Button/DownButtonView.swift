//
//  DownButtonView.swift
//  Coingate
//
//  Created by Victor on 05/11/2023.
//

import SwiftUI

struct DownButtonView: View {
    var body: some View {
        Image("down_arrow")
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(.gray900)
            .scaledToFit()
            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(8)
            //.background(Color.theme.gray50)
            //.clipShape(Circle())
    }
}

#Preview {
    DownButtonView()
}

//
//  EmojiHeaderView.swift
//  Coingate
//
//  Created by Victor on 02/11/2023.
//

import SwiftUI

struct EmojiHeaderView: View {
    @EnvironmentObject  var namespaceWrapper: NamespaceWrapper
    let layers: LayerModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(content: {
                Text("Choose an emoji")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray900)
//                    .matchedGeometryEffect(
//                        id: "layer.header",
//                        in: namespaceWrapper.namespace
//                    )
                Spacer()
                
                Image("close")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(8)
                    .foregroundStyle(.gray400)
                    .background(.gray100)
                    .clipShape(Circle())
            })
            Divider()
        }
        .transition(.asymmetric(
            insertion: .scale(scale: 0.8, anchor: .bottom).combined(with: .opacity).animation(.spring(response: 0.22, dampingFraction: 1, blendDuration: 1)),
            removal: .scale(scale: 0.8).combined(with: .opacity).animation(.spring(response: 0.07, dampingFraction: 1, blendDuration: 1))))
    }
}

#Preview {
    EmojiHeaderView(layers: dev.layer)
}

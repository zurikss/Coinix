//
//  ThemesCompView.swift
//  Coingate
//
//  Created by Victor on 25/11/2023.
//

import SwiftUI

struct ThemesCompView: View {
    
    let disClose: () -> Void
    
    @Bindable var layers: LayerModel = .init(
        index: 0,
        max: 4,
        headers: [
            0: AnyView(ThemeHeader(layers: dev.layer)),
        ],
        contents: [
            0: AnyView(ThemeView()),
        ],
        buttons: [
            0: [["Use Memoji": "memoji_placeholder"], ["Use Emoji": "laugh"], ["Use Icon": "heart"]],
            1: [[ : ], [ : ], [ : ]],
            2: [[ : ], [ : ], [ : ]],
            3: [[ : ], [ : ], [ : ]],

        ]
    )

    var body: some View {
        Layer {
            Button {
                if layers.index == 0 {
                    withAnimation(.spring(response: 0.38, dampingFraction: 0.88, blendDuration: 1)) {
                        disClose()
                        HapticsManager.instance.impact(style: .soft)
                    }
                    
                }
                
            } label: {
                layers.getCurrentHeader()
                    .id("layer.stack.header.\(layers.index)")
            }
            .buttonStyle(BouncyButton())

            
            layers.getCurrentContent()
                .id("layer.stack.content.\(layers.index)")
                .padding(.top, 24)
            

        }
    }
}

#Preview {
    ThemesCompView{}
}

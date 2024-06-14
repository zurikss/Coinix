//
//  SelectProfileView.swift
//  Coingate
//
//  Created by Victor on 02/11/2023.
//

import SwiftUI

struct SelectProfileView: View {
    
    @EnvironmentObject var namespaceWrapper: NamespaceWrapper

    @Binding var text: String
    @Binding var icon: String

    @State var id: Int
    @State var background: Color
    @State var disabled: Bool
    @State var foregroundColor: Color? = nil
    @State var pressed = false
    @State var action: () -> Void
    
    internal init(
        id: Int = Int.random(in: 1 ..< 100000000),
        text: Binding<String> = .constant("Confirm"),
        icon: Binding<String> = .constant("heart"),
        background: Color = Color(.systemBlue),
        foregroundColor: Color? = nil,
        disabled: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.id = id
        self._text = text
        self._icon = icon
        self.action = action
        self.background = background
        self.foregroundColor = foregroundColor
        self.disabled = disabled
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            memoji
            //emoji
            //selectIcon
        })
        .transition(.asymmetric(
            insertion: .scale(scale: 0.8).animation(.spring(response: 0.35, dampingFraction: 1, blendDuration: 1)),
            removal: .scale(scale: 0.8).combined(with: .opacity).animation(.spring(response: 0.05, dampingFraction: 1, blendDuration: 1))))
    }
}

#Preview {
    SelectProfileView()
}

extension SelectProfileView {
    private var memoji: some View {
        Button(action: {
            
        }, label: {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 12, content: {
                if icon != "" {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24, alignment: .center)
                        .clipShape(Circle())
                }
                
                Text(text)
                    .font(.body)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray900)
                
                Spacer()
            })
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .background(Color.theme.gray100)
            .clipShape(RoundedRectangle(cornerRadius: 16))

        })
        .buttonStyle(BouncyButton())
        
    }
    
    private var emoji: some View {
        Button(action: {
            
        }, label: {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 12, content: {
                Text("😂")
                    .font(.body)
                
                Text("Use Memoji")
                    .font(.body)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray900)
                
                Spacer()
            })
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .background(Color.theme.gray100)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        })
        .buttonStyle(BouncyButton())

    }
    
    private var selectIcon: some View {
        Button(action: {
            
        }, label: {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 12, content: {
                Image("heart")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundStyle(.gray400)
                    .frame(width: 24, height: 24, alignment: .center)
                
                Text("Use Icon")
                    .font(.body)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray900)
                
                Spacer()
            })
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .background(Color.theme.gray100)
            .clipShape(RoundedRectangle(cornerRadius: 16))

        })
        .buttonStyle(BouncyButton())

    }
}

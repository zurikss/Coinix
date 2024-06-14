//
//  LaunchView.swift
//  Coingate
//
//  Created by Victor on 15/12/2023.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var logoText: [String] = "Agios".map {String($0)}
    @State private var showLogoText: Bool = false
    
    private let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(content: {
                Color.launch.background.ignoresSafeArea()
                  
                ZStack(content: {
                    if showLogoText {
                        HStack(spacing: 0) {
                            ForEach(logoText, id: \.self) { index in
                                Text(index)
                                    .font(.largeTitle)
                                    .kerning(-1)
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold) 
                                    .foregroundStyle(Color.launch.accent)
                            }
                        }
                        .transition(AnyTransition.push(from: .leading).animation(.easeIn))
                    }
                })
                .offset(x: showLogoText ? 17 : 0)
                .animation(.spring(response: 0.35, dampingFraction: 1, blendDuration: 1), value: showLogoText)
                
                //LottieView(name: "speechify", loopMode: .loop, contentMode: .scaleAspectFit)

                
                Image("appIcon")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: showLogoText ? -165 : 0)
                    .scaleEffect(showLogoText ? 0.4 : 1)
                    .animation(.spring(response: 0.35, dampingFraction: 1, blendDuration: 1), value: showLogoText)
                
            })
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    showLogoText.toggle()
                }
               
            }
            .onReceive(timer, perform: { _ in
                withAnimation(.easeIn) {
                    let lastIndex = logoText.count - 1
                    if counter == lastIndex {
                        counter = 0
                        loops += 1
                        if loops > 1 {
                            showLaunchView = false
                        }
                    } else  {
                        counter += 1
                    }
                }
        })
            if showLogoText {
                HStack(spacing: 6) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .frame(width: 12, height: 12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .opacity(counter == index ? 0.8 : 0)
                    }
                }
                .transition(AnyTransition.opacity.animation(.easeOut))
            }
            
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}

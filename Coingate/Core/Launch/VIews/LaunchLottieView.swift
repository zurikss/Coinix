//
//  LaunchLottieView.swift
//  Coingate
//
//  Created by Victor on 18/12/2023.
//

import SwiftUI

struct LaunchLottieView: View {
    @State private var showLottie: Bool = false
    private let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack(content: {
            Color.launch.accent.ignoresSafeArea()
            
            
            
            LottieView(name: "coinix_dark", loopMode: .playOnce, animationSpeed: 1, contentMode: .scaleAspectFit)
                .frame(width: 240, height: 240, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            
        })
        .onAppear {
                showLottie.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.easeIn) {
                counter += 1
                if counter == 9 {
                    showLaunchView = false 
                }
            }
    })

    }
}

#Preview {
    LaunchLottieView(showLaunchView: .constant(true))
}

//
//  LottieView.swift
//  Coingate
//
//  Created by Victor on 17/12/2023.
//

import SwiftUI
import Lottie


struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    let contentMode: UIView.ContentMode
    
    let animationView: LottieAnimationView
    
    init(name: String, loopMode: LottieLoopMode, animationSpeed: CGFloat = 1, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.name = name
        self.animationView = LottieAnimationView(name: name)
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
        self.contentMode = contentMode
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.contentMode = contentMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.loopMode = loopMode
        animationView.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

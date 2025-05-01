//
//  MorphingSymbolView.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

struct MorphingSymbolView: View {
    @State private var trigger: Bool = false
    @State private var displayingSymbol: String = ""
    @State private var nextSymbol: String = ""
    
    var symbol: String
    var config: Config
    
    var body: some View {
        Canvas { ctx, size in
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))
            
            if let renderedImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderedImage, at: CGPoint(x: size.width / 2, y: size.height / 2))
            }
        } symbols: {
            ImageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { _, newValue in
            trigger.toggle()
            nextSymbol = newValue
        }
        .task {
            guard displayingSymbol.isEmpty else { return }
            displayingSymbol = symbol
        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            Image(systemName: displayingSymbol.isEmpty ? symbol : displayingSymbol)
                .font(config.font)
                .blur(radius: radius) // 중요 포인트 중 하나임
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: radius) { oldValue, newValue in
                    if newValue.rounded() == config.radius {
                        /// Animating Symbol Change
                        withAnimation(config.symbolAnimation) {
                            displayingSymbol = nextSymbol
                        }
                    }
                }
        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: config.keyFrameDuration)
            CubicKeyframe(0, duration: config.keyFrameDuration)
        }
    }
    
    struct Config {
        var font: Font
        var frame: CGSize
        var radius: CGFloat
        var foregroundColor: Color
        var keyFrameDuration: CGFloat = 0.4
        var symbolAnimation: Animation = .smooth(duration: 0.5, extraBounce: 0)
    }
}

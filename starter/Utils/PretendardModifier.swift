//
//  PretendardModifier.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

enum Weight {
    case Thin, ExtraLight, Light
    case Regular, Medium
    case SemiBold, Bold, ExtraBold, Black
}

enum Style {
    case LargeTitle, Title1, Title2, Title3
    case Headline
    case Body, Callout, Subheadline
    case Footnote
    case Caption1, Caption2
}

struct PretendardStyle: ViewModifier {
    let weight: Weight
    let style: Style
    let color: Color
    
    init(weight: Weight, style: Style, color: Color = .white) {
        self.weight = weight
        self.style = style
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName(from: weight), size: fontSize(from: style)))
            .foregroundStyle(color)
    }
    
    func fontName(from: Weight) -> String {
        switch from {
        case Weight.Thin:
            return "Pretendard-Thin"
        case Weight.ExtraLight:
            return "Pretendard-ExtraLight"
        case Weight.Light:
            return "Pretendard-Light"
        case Weight.Regular:
            return "Pretendard-Regular"
        case Weight.Medium:
            return "Pretendard-Medium"
        case Weight.SemiBold:
            return "Pretendard-SemiBold"
        case Weight.Bold:
            return "Pretendard-Bold"
        case Weight.ExtraBold:
            return "Pretendard-ExtraBold"
        case Weight.Black:
            return "Pretendard-Black"
        }
    }
    
    func fontSize(from: Style) -> CGFloat {
        switch from {
        case Style.LargeTitle:
            return 34
        case Style.Title1:
            return 28
        case Style.Title2:
            return 22
        case Style.Title3:
            return 20
        case Style.Headline:
            return 17
        case Style.Body:
            return 17
        case Style.Callout:
            return 16
        case Style.Subheadline:
            return 15
        case Style.Footnote:
            return 13
        case Style.Caption1:
            return 12
        case Style.Caption2:
            return 11
        }
    }
}

extension View {
    func pretendardStyle(by: Weight, on: Style, fill: Color = .white) -> some View {
        modifier(PretendardStyle(weight: by, style: on, color: fill))
    }
}

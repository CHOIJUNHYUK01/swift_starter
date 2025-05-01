//
//  OnboardingPage.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

enum OnboardingPage: String, CaseIterable {
    case page1 = "person.icloud.fill"
    case page2 = "cloud.sun.fill"
    case page3 = "moon.stars.fill"
    case page4 = "pencil.and.outline"
    case page5 = "book.fill"
    
    var title: String {
        switch self {
        case .page1: "당신의 하늘, 당신의 마음"
        case .page2: "오늘의 하늘은 어땠나요?"
        case .page3: "당신의 감정은 어떤가요?"
        case .page4: "더 남기고 싶은 이야기가 있나요?"
        case .page5: "당신만의 언어를 남겨봐요!"
        }
    }
    
    var subTitle: String {
        switch self {
        case .page1: "날마음에 오신 것을 환영합니다."
        case .page2: "당신만의 하늘을 기록해보세요."
        case .page3: "솔직한 마음을 담아보세요."
        case .page4: "특별한 순간, 하고 싶은 말을 자유롭게 적어보세요."
        case .page5: "지금 시작해볼까요?"
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1: 0
        case .page2: 1
        case .page3: 2
        case .page4: 3
        case .page5: 4
        }
    }
    
    var nextPage: OnboardingPage {
        let index = Int(self.index) + 1
        
        if index < 5 {
            return OnboardingPage.allCases[index]
        }
        
        return self
    }
    
    var perviousPage: OnboardingPage {
        let index = Int(self.index) - 1
        
        if index >= 0 {
            return OnboardingPage.allCases[index]
        }
        
        return self
    }
}

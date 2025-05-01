//
//  AppReviewManager.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import StoreKit
import SwiftUI

class AppReviewManager: ObservableObject {
    @AppStorage("reviewRequestCount") private var requestCount = 0
    @AppStorage("lastReviewRequestDate") private var lastRequestDate = Date.distantPast.timeIntervalSince1970
    
    // 리뷰 요청 최소 간격
    private let minimumDaysBetweenRequests: Double = 30
    
    // 리뷰 요청 횟수 제한
    private let maxReviewRequests = 3
    
    func shouldRequestReview() -> Bool {
        guard requestCount < maxReviewRequests else {
            return false
        }
        
        // 마지막 요청 날짜 확인
        let lastRequestDateTime = Date(timeIntervalSince1970: lastRequestDate)
                let daysSinceLastRequest = Calendar.current.dateComponents(
                    [.day],
                    from: lastRequestDateTime,
                    to: Date()
                ).day ?? 0
                
                return Double(daysSinceLastRequest) >= minimumDaysBetweenRequests
    }
    
    func autoRequestReview() {
        guard shouldRequestReview() else { return }
        
        // 리뷰 요청 횟수 증가
        requestCount += 1
        // 마지막 요청 시간 업데이트
        lastRequestDate = Date().timeIntervalSince1970
        
        // 리뷰 요청
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    func forceRequestReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}

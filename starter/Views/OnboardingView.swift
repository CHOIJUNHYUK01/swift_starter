//
//  OnboardingView.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var activePage: OnboardingPage = .page1
    @State private var showStartSheet: Bool = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack {
                Spacer(minLength: 0)
                
                MorphingSymbolView(
                    symbol: activePage.rawValue,
                    config: .init(
                        font: .custom("Pretendard-Bold", size: 150),
                        frame: .init(width: 250, height: 200),
                        radius: 30,
                        foregroundColor: .white
                    )
                )
                
                TextContents(size: size)
                
                Spacer(minLength: 0)
                
                IndicatorView
                
                ContinueButton
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                HeaderView
            }
            .ignoresSafeArea(.keyboard)
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .ignoresSafeArea()
        }
        .floatingBottomSheet(isPresented: $showStartSheet) {
            StartSheetView(
                onSuccess: {
                    showStartSheet = false
                    hasCompletedOnboarding = true
                },
                onDismiss: {
                    showStartSheet = false
                }
            )
            .presentationDetents([.height(220)])
            .interactiveDismissDisabled()
        }
    }
    
    private var HeaderView: some View {
        HStack {
            Button {
                activePage = activePage.perviousPage
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button("넘어가기") {
                activePage = .page5
            }
            .font(.custom("Pretendard-SemiBold", size: 16))
            .opacity(activePage != .page5 ? 1 : 0)
        }
        .foregroundStyle(.white)
        .animation(.snappy(duration: 0.35, extraBounce: 0), value: activePage)
        .padding(15)
    }
    
    func TextContents(size: CGSize) -> some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    Text(page.title)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .kerning(1.1)
                        .frame(width: size.width)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.bouncy(duration: 0.7, extraBounce: 0), value: activePage)
            
            HStack(alignment: .top, spacing: 0) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    Text(page.subTitle)
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: size.width)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.bouncy(duration: 0.9, extraBounce: 0), value: activePage)
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    private var IndicatorView: some View {
        HStack(spacing: 6) {
            ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
        .padding(.bottom, 12)
    }
    
    private var ContinueButton: some View {
        Button {
            if activePage != .page5 {
                activePage = activePage.nextPage
            } else {
                showStartSheet = true
            }
        } label: {
            Text(activePage == .page5 ? "시작하기" : "계속하기")
                .font(.body)
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                .contentTransition(.identity)
                .padding(.vertical, 15)
                .frame(maxWidth: 220)
                .background(.white, in: .capsule)
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
}

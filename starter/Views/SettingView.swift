//
//  SettingView.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import CoreLocation
import Photos
import SwiftUI

struct SettingView: View {
    @AppStorage("userName") private var userName = "닉네임"
    @StateObject private var reviewManager = AppReviewManager()
    
    @State private var tempUserName = ""
    
    let characterLimit = 15

    var body: some View {
        GeometryReader { _ in
            ScrollView {
                LazyVStack(spacing: 20) {
                    SettingSection(title: "이름 변경") {
                        ZStack {
                            HStack(spacing: 4) {
                                Image(systemName: "person")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.gray)
                                
                                TextField(userName, text: $userName)
                                    .font(.body)
                                    .foregroundStyle(.white)
                                    .onChange(of: userName) { _, newValue in
                                        if newValue.count > characterLimit {
                                            userName = String(newValue.prefix(characterLimit))
                                        }
                                    }
                                    .autocorrectionDisabled()
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.gray.opacity(0.3))
                            }
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text("\(userName.count)/15")
                                        .font(.caption2)
                                        .foregroundStyle(userName.count >= characterLimit ? .red : .gray)
                                        .fontWeight(.light)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 4) {
                        Button {
                            if let url = URL(string: "https://dorogono.com/products/moodsky/privacy/") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                                HStack {
                                    Text("개인정보처리방침")
                                        .font(.body)
                                        .foregroundStyle(.white)
                                        .fontWeight(.light)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                }
                                .padding(.horizontal, 16)
                        }
                        
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                        
                        Button {
                            if let url = URL(string: "https://dorogono.com/products/moodsky/terms_of_service/") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                                HStack {
                                    Text("서비스이용약관")
                                        .font(.body)
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                }
                                .padding(.horizontal, 16)
                        }
                    }
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.gray.opacity(0.3))
                    }
                    
                    Button {
                        reviewManager.forceRequestReview()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(height: 42)
                                .foregroundStyle(.gray.opacity(0.3))
                            
                            HStack {
                                Text("앱스토어 리뷰 남기기")
                                    .font(.body)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Image(systemName: "star")
                                    .foregroundStyle(.yellow)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    
                    VStack(alignment: .center) {
                        Text("현재 버전 정보")
                            .font(.callout)
                            .foregroundStyle(.gray.opacity(0.4))
                            .fontWeight(.bold)
                        Text("v\(AppVersion.current)")
                            .font(.caption2)
                            .foregroundStyle(.gray.opacity(0.4))
                    }
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 16)
            .background(.black.gradient)
            .dismissKeyboard()
        }
        .navigationTitle("설정")
    }
    
    private func SettingSection(title: String, content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
            
            content()
        }
    }
}

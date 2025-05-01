//
//  UpdateAlertView.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

struct UpdateAlertView: View {
    @Environment(\.openURL) private var openURL
    @Binding var isPresented: Bool
    
    let currentVersion: String
    let latestVersion: String
    let releaseNotes: String
    let appId: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "arrow.down.app")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Text("업데이트가 있습니다")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("현재 버전: \(currentVersion)\n최신 버전: \(latestVersion)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            if !releaseNotes.isEmpty {
                Text("업데이트 내용")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView {
                    Text(releaseNotes)
                        .font(.body)
                        .padding()
                        .frame(maxHeight: 200)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            
            HStack(spacing: 16) {
                Button("나중에") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Button {
                    if let url = URL(string: "https://apps.apple.com/app/id\(appId)") {
                        openURL(url)
                    }
                    isPresented = false
                } label: {
                    Text("업데이트")
                        .bold()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(maxWidth: 320)
    }
}

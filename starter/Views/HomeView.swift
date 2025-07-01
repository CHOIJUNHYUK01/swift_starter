//
//  HomeView.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var updateChecker: AppUpdateChecker
    @State private var showUpdateAlert = false
    @State private var hasShownUpdateAlert = false // 업데이트 알림을 이미 보여줬는지 추적
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("망구랑, 킹냥이, 캬앙이")
                }
                .sheet(isPresented: $showUpdateAlert) {
                    UpdateAlertView(
                        isPresented: $showUpdateAlert,
                        currentVersion: AppVersion.current,
                        latestVersion: updateChecker.latestVersion,
                        releaseNotes: updateChecker.releaseNotes,
                        appId: AppVersion.appId
                    )
                    .presentationDetents([.height(400)])
                }
            }
            .task {
                await updateChecker.checkForUpdates(appId: AppVersion.appId)
                showUpdateAlert = updateChecker.isUpdateAvailable
            }
            .onAppear {
                if hasShownUpdateAlert {
                    showUpdateAlert = false
                }
            }
            .onChange(of: showUpdateAlert) { _, newValue in
                if !newValue {
                    hasShownUpdateAlert = true
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

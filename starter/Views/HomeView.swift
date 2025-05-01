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
        }
    }
}

#Preview {
    HomeView()
}

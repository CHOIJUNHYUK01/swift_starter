//
//  AppUpdateChecker.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

struct AppVersion {
    static let current: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    static let build: String = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    static let appId: String = "6670235683"
    
    static var fullVersion: String {
        "\(current) (\(build))"
    }
}

class AppUpdateChecker: ObservableObject {
    @Published var isUpdateAvailable = false
    @Published var latestVersion: String = ""
    @Published var releaseNotes: String = ""
    @AppStorage("lastUpdateCheckDate") private var lastUpdateCheckDate = Date.distantPast.timeIntervalSince1970
    
    private let minimumCheckInterval: TimeInterval = 24 * 3600 // 24시간
    
    func checkForUpdates(appId: String) async {
        // 마지막 체크로부터 24시간이 지나지 않았다면 스킵
        let lastCheck = Date(timeIntervalSince1970: lastUpdateCheckDate)
        guard Date().timeIntervalSince(lastCheck) >= minimumCheckInterval else { return }
        
        do {
            guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(appId)") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let results = json["results"] as? [[String: Any]],
               let appStoreVersion = results.first?["version"] as? String,
               let notes = results.first?["releaseNotes"] as? String {
                await MainActor.run {
                    self.latestVersion = appStoreVersion
                    self.releaseNotes = notes
                    self.isUpdateAvailable = appStoreVersion != AppVersion.current
                    self.lastUpdateCheckDate = Date().timeIntervalSince1970
                }
                
            }
        } catch {
            print("Update check failed: \(error)")
        }
    }
}

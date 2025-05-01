//
//  starterApp.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

@main
struct starterApp: App {
    @StateObject private var updateChecker = AppUpdateChecker()
    // SwiftData 사용시
    // @StateObject private var dataViewModel: DataViewModel
    
//    init() {
//        let container = try! ModelContainer(
//            for: DataModel.self
//        )
//        _memoViewModel = StateObject(
//            wrappedValue: DataViewModel(
//                modelContext: container.mainContext
//            )
//        )
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(updateChecker)
//                .environmentObject(dataViewModel)
        }
//        .modelContainer(for: [DataModel.self])
    }
}

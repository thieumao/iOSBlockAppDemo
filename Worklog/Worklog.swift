//
//  WorklogApp.swift
//  Worklog
//
//  Created by Mobile Programming  on 21/08/23.
//

import SwiftUI
import FamilyControls
import DeviceActivity


@main
struct Worklog: App {
    let center = AuthorizationCenter.shared


    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
            .onAppear {
                Task {
                    do {
                        try await center.requestAuthorization(for: .individual)
                        print("Dang xin")
                    } catch {
                        print("Failed to enroll Aniyah with error: \(error)")
                    }
                }
                
                
//                AuthorizationCenter.shared.requestAuthorization { result in
//                    switch result {
//                    case .success:
//                        break
//                    case .failure(let error):
//                        print("error for screentime is \(error)")
//                    }
//                }

                _ = AuthorizationCenter.shared.$authorizationStatus
                    .sink() {_ in
                    switch AuthorizationCenter.shared.authorizationStatus {
                    case .notDetermined:
                        print("not determined")
                    case .denied:
                        print("denied")
                    case .approved:
                        print("approved")
                    @unknown default:
                        break
                    }
                }
                

                
            }
        }
    }
}

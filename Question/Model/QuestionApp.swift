//
//  QuestionApp.swift
//  Question
//
//  Created by 正木脩平 on 2021/01/29.
//

import SwiftUI
import Firebase
import GoogleMobileAds

@main
struct QuestionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let boolists = boolist()
            ContentView().environmentObject(boolists)
                .environment(\.locale, Locale(identifier: "ja_JP"))
        }
    }
}
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}

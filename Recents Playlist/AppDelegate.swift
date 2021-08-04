//
//  App.swift
//  RecentsiOS
//
//  Created by Jasjeev on 5/17/21.
//

import Foundation
import SwiftUI
import SpotifyLogin

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        SpotifyLogin.shared.configure(clientID: "", clientSecret: "", redirectURL: URL(string: "recentsplaylist-ios://spotify-login-callback")!)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = SpotifyLogin.shared.applicationOpenURL(url) { (error) in }
        return handled
    }
}

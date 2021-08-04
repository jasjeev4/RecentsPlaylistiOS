//
//  Recents_PlaylistApp.swift
//  Recents Playlist
//
//  Created by Jasjeev on 5/24/21.
//

import SwiftUI
import SpotifyLogin

@main
struct Recents_PlaylistApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var spotifyService = SpotifyService()
    var recentsModel: RecentsModel
    
    init() {
        recentsModel =  RecentsModel(spotifyService)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                // handle the URL that must be opened
                SpotifyLogin.shared.applicationOpenURL(url) { (error) in }
            }.environmentObject(spotifyService)
             .environmentObject(recentsModel)
        }
    }
}

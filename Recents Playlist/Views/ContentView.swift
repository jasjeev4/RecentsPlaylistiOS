//
//  ContentView.swift
//  RecentsiOS
//
//  Created by Jasjeev on 5/17/21.
//

import SwiftUI
import SpotifyLogin

struct ContentView: View {
    @EnvironmentObject var spotifyService: SpotifyService
    @EnvironmentObject var recentsModel: RecentsModel

    var body: some View {
        if(spotifyService.isLoggedIn) {
            // User is not logged in, show log in flow.
            return AnyView(HomeView())
        }
        else {
            return AnyView(LoginView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

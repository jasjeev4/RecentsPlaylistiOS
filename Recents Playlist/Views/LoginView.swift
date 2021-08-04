//
//  LoginView.swift
//  RecentsiOS
//
//  Created by Jasjeev on 5/18/21.
//

import SwiftUI

struct LoginView: View {
    // MARK: - Properties
    // @ObservedObject private var loginViewModel = LoginViewModel()
    // @EnvironmentObject var spotifyService: SpotifyService

    // MARK: - UI
    var body: some View {
        VStack{
            Spacer()
            HStack(alignment: .top) {
                VStack(alignment: .center, spacing: 32.0) {
                    Text("Recents Playlist".uppercased())
                        .kerning(1.0)
                        .fontWeight(.heavy)
                        .font(.title)
                        .padding()

                    VStack(spacing: 8.0) {
                        Text("Connect with your Spotify account")
                            .kerning(1.0)
                            .fontWeight(.bold)
                            .font(.callout)
                            .padding()

                        ConnectButtonView()
                            .frame(minWidth: 0,
                                   maxWidth: UIScreen.main.bounds.width,
                                   minHeight: 0,
                                   maxHeight: 60)
                    }
                }
            }
            Spacer()
        }
    }
}

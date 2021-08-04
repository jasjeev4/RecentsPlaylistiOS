//
//  ConnectButtonView.swift
//  RecentsiOS
//
//  Created by Jasjeev on 5/20/21.
//

import SwiftUI

// MARK: - ConnectButtonView
struct ConnectButtonView {
    // MARK: - Properties
    @EnvironmentObject var spotifyService: SpotifyService
}

// MARK: - ConnectButtonView: UIViewControllerRepresentable
extension ConnectButtonView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SpotifyLoginViewController

    func makeUIViewController(context: Context) -> SpotifyLoginViewController {
        return SpotifyLoginViewController()
    }

    func updateUIViewController(_ uiViewController: SpotifyLoginViewController, context: Context) {

    }
}


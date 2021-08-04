//
//  SpotifyService.swift
//  RecentsiOS
//
//  Created by Jasjeev on 5/18/21.
//

import Foundation
import SpotifyLogin

public class SpotifyService: ObservableObject {

    @Published public var isLoggedIn: Bool = false
    
    public static let loginScopes: [Scope] = [
        .userReadPrivate,
        .userReadEmail,
        .playlistReadPrivate,
        .playlistModifyPrivate,
        .playlistModifyPublic,
        .playlistModifyPrivate,
        .userLibraryRead,
        .userLibraryModify,
        .userReadTop,
        .userReadCurrentlyPlaying,
        .userModifyPlaybackState,
        .playlistReadCollaborative,
    ]
    
    public init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didLoginSuccessfully),
                                               name: .SpotifyLoginSuccessful,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func login(completion: ((String?, Error?) -> Void)? = nil) {
        SpotifyLogin.shared.getAccessToken { (accessToken, error) in
            self.isLoggedIn = (accessToken != nil)
            completion?(accessToken, error)
        }
    }
    
    public func getAccessToken(completion: ((String?, Error?) -> Void)? = nil){
        SpotifyLogin.shared.getAccessToken {(accessToken, error) in
            if error == nil {
                completion?(accessToken, nil)
            }
            else {
                completion?(nil, error)
            }
        }
    }
    
    public func logout() {
        SpotifyLogin.shared.logout()
        self.isLoggedIn = false
    }

    @objc private func didLoginSuccessfully() {
        SpotifyLogin.shared.getAccessToken { [weak self] (accessToken, error) in
            self?.isLoggedIn = (accessToken != nil)
        }
    }
}


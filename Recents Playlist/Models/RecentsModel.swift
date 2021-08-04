//
//  RecentsModel.swift
//  Recents Playlist
//
//  Created by Jasjeev on 5/25/21.
//

import Foundation
import SwiftyJSON

class RecentsModel: ObservableObject {
    @Published var shouldRedirectToHomeView = false
    
    @Published var showLoginSamePlaylist = false
    @Published var showLoginNewPlaylist = false
    @Published var regeneratedPlaylist = false
    
    var tracks = [Track]()
    var playlistID: String?
    var spotfiyServiceInstance: SpotifyService?
    
    let baseurl = "https://us-central1-primary-server-168620.cloudfunctions.net/recents-ios?token="
    
    init(_ spotifyService: SpotifyService?) {
        spotfiyServiceInstance = spotifyService ?? nil
    }
    
    func onLogin(spotifyService: SpotifyService){
        spotifyService.getAccessToken{(accessToken, error) in
            if error == nil {
                self.makeRequest(accessToken: accessToken!, login: "1")
            }
            else {
                print(error!)
            }
        }
    }
    
    func regenerate(spotifyService: SpotifyService){
        spotifyService.getAccessToken{(accessToken, error) in
            if error == nil {
                self.makeRequest(accessToken: accessToken!, login: "0")
            }
            else {
                print(error!)
            }
        }
    }
    
    
    func makeRequest(accessToken: String, login: String = "true") {
        let stringurl = baseurl + accessToken + "&login=" + login
        guard let url = URL(string: stringurl) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil){
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
            else
            {
                if let data = data {
                    // let returnData = String(data: data, encoding: .utf8)
                    let json = JSON(data)
                    debugPrint(json)
                        // we have good data – go back to the main thread
                    DispatchQueue.main.async { [self] in
                        print(json["status"].intValue)
                        // update our UI
                        if(json["status"].intValue == 1) {
                            self.processPlaylist(result: json["result"], login: login)
                        }
                        else {
                            spotfiyServiceInstance?.isLoggedIn = false
                            
                            // Show an error to the user
                            
                            print("There was an error with the backend")
                            print(data)
                        }
                    }
                    // everything is good, so we can exit
                    return
                }
            }
        }.resume()
    }
    
    func processPlaylist(result: JSON, login: String) {
        // ensure tracks is empty
        self.tracks.removeAll()
        
        let playlist = result["playlist"]["tracks"]
        
        self.playlistID = result["playlist"]["playlist_id"].stringValue
    
        
        for (_, trackData):(String, JSON) in playlist {
            let currentTrack = Track(
                name: trackData["name"].stringValue,
                artists: trackData["artists"].stringValue,
                album: trackData["album"].stringValue,
                image: trackData["image"].stringValue
            )
            self.tracks.append(currentTrack)
        }
        
        self.shouldRedirectToHomeView = true
        
        // process alert to show
        displayToast(login: login, regenerated: result["regenerated"].intValue)
    }
    
    func displayToast(login: String, regenerated: Int?) {
        guard let regen = regenerated else {
            return
        }
        
        if(login=="1") {
            if(regen == 0) {
                self.showLoginSamePlaylist = true
            }
            else {
                self.showLoginNewPlaylist = true
            }
        }
        else {
            if(regen == 1) {
                self.regeneratedPlaylist = true
            }
        }
    }
}


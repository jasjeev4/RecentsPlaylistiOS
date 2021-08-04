//
//  HomeView.swift
//  RecentsiOS
//
//  Created by Jasjeev on 5/18/21.
//

import SwiftUI
import SwiftyJSON
import AlertToast

// MARK: HomeView
/// `HomeView` shows a list of tab items with its contents.

extension UIColor {
    static let goldColor = UIColor(red: 252.0/255.0, green: 195.0/255.0, blue: 0.0/255.0, alpha: 1.0)
}

struct HomeView: View {
    @EnvironmentObject var spotifyService: SpotifyService
    @EnvironmentObject var recentsModel: RecentsModel
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView{
            VStack{
                if(self.recentsModel.shouldRedirectToHomeView) {
                    ZStack(alignment: Alignment.top) {
                        List(self.recentsModel.tracks) { track in
                            TrackRow(track: track)
                        }.listStyle(GroupedListStyle())
                    }.edgesIgnoringSafeArea(.vertical)
                }
                else {
                    ProgressView()
                        .scaleEffect(2.5, anchor: .center)
                }
            }.navigationBarTitle(Text("Recents Playlist"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button() {
                            guard let playlistid = self.recentsModel.playlistID, let plurl = URL(string: "https://open.spotify.com/playlist/" + playlistid) else {
                                return
                            }
                            openURL(plurl)
                            print("Open Playlist Clicked")
                        } label: {
                            Label("Open Playlist", systemImage: "play.square.fill")
                        }
                        
                        Button() {
                            self.recentsModel.regenerate(spotifyService: self.spotifyService)
                            
                            print("Regenerate Clicked")
                        } label: {
                            Label("Regenerate Playlist", systemImage: "arrow.triangle.2.circlepath.circle.fill")
                        }
                        
                        Button() {
                            recentsModel.tracks.removeAll()
                            self.spotifyService.logout()
                        } label: {
                            Label("Logout", systemImage: "rectangle.portrait.and.arrow.right.fill")
                        }
                    }label: {
                        Label("Options", systemImage: "slider.horizontal.3")
                    }
                }
            }
            .onAppear{
                self.recentsModel.onLogin(spotifyService: spotifyService)
            }
            .toast(isPresenting: $recentsModel.showLoginNewPlaylist){
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: "Welcome! 👋 Here's your playlist of recently added tracks!")
            }
            .toast(isPresenting: $recentsModel.showLoginSamePlaylist){
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: "Welcome back! 👋 Your playlist of recently addded tracks is still here!")
            }
            .toast(isPresenting: $recentsModel.regeneratedPlaylist){
                // `.alert` is the default displayMode
                AlertToast(type: .regular, title: "Done! ✌️ We updated your recently songs to the playlist!")
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


#if DEBUG
// MARK: - HomeView_Previews: PreviewProvider
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif

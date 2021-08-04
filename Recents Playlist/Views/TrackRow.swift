//
//  Track.swift
//  Recents Playlist
//
//  Created by Jasjeev on 5/25/21.
//

import SwiftUI
import URLImage

struct Track: Identifiable {
    let id = UUID()
    let name: String
    let artists: String
    let album: String
    let image: String
}

// A view that shows the data for one Track.
struct TrackRow: View {
    var track: Track

    var body: some View {
        HStack {
            URLImage(URL(string: track.image)!) {
                // This view is displayed before download starts
                EmptyView()
            } inProgress: { progress in
                // Display progress
                EmptyView()
            } failure: { error, retry in
                // Display error and retry button
                Image("no-image")
            } content: { image in
                // Downloaded image
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }.frame(minWidth: 100, maxWidth: 100, minHeight: 100, maxHeight: 100)
            
            VStack(alignment: .leading){
                Text(track.name).fontWeight(.heavy)
                Text(track.artists)
            }.padding()
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

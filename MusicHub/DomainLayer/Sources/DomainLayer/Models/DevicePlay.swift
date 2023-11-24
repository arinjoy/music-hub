//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation

public struct DevicePlay: Identifiable {

    public let id: Int32
    public let roomName: String

    public let artwork: MusicArtWork
    public let info: MusicInfo

    public init(id: Int32, roomName: String, artwork: MusicArtWork, info: MusicInfo) {
        self.id = id
        self.roomName = roomName
        self.artwork = artwork
        self.info = info
    }
}

public struct MusicArtWork {

    public let smallUrl: URL
    public let largeUrl: URL

    public init(smallUrl: URL, largeUrl: URL) {
        self.smallUrl = smallUrl
        self.largeUrl = largeUrl
    }
}

public struct MusicInfo {
    public let trackName: String
    public let artistName: String

    public init(trackName: String, artistName: String) {
        self.trackName = trackName
        self.artistName = artistName
    }
}



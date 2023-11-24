//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation

public struct Music: Decodable {
    public let deviceId: Int32
    public let artworkSmallUrl: String
    public let artworkLargeUrl: String
    public let trackName: String
    public let artistName: String

    private enum CodingKeys: String, CodingKey {
        case deviceId = "Device ID"
        case artworkSmallUrl = "Artwork Small"
        case artworkLargeUrl = "Artwork Large"
        case trackName = "Track Name"
        case artistName = "Artist Name"
    }
}

public struct NowPlayingMusicListResponse: Decodable {
    public let playList: [Music]

    private enum CodingKeys: String, CodingKey {
        case playList = "Now Playing"
    }
}

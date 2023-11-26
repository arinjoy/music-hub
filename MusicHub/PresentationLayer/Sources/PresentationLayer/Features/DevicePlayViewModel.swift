//
//  Created by Arinjoy Biswas on 25/11/2023.
//

import Foundation
import DomainLayer

class DevicePlayViewModel: ObservableObject, Identifiable {

    // MARK: - Properties

    @Published var isPlaying: Bool

    let id: Int32
    let roomName: String
    let musicTrackName: String
    let musicArtistName: String
    let smallImageURL: URL
    let largeImageURL: URL

    // MARK: - Initializer

    init(
        isPlaying: Bool = false,
        model: DevicePlay
    ) {
        self.isPlaying = isPlaying
        self.id = model.id
        self.roomName = model.roomName
        self.musicTrackName = model.info.trackName
        self.musicArtistName = model.info.artistName
        self.smallImageURL = model.artwork.smallUrl
        self.largeImageURL = model.artwork.largeUrl
    }
}

import Foundation
import DomainLayer

class DevicePlayViewModel: ObservableObject, Identifiable, Equatable {

    static func == (lhs: DevicePlayViewModel, rhs: DevicePlayViewModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.isPlaying == rhs.isPlaying
    }

    // MARK: - Properties

    @Published var isPlaying: Bool = false

    let id: Int32
    let roomName: String
    let musicTrackName: String
    let musicArtistName: String
    let smallImageURL: URL
    let largeImageURL: URL

    // MARK: - Initializer

    init(
        model: DevicePlay
    ) {
        self.id = model.id
        self.roomName = model.roomName
        self.musicTrackName = model.info.trackName
        self.musicArtistName = model.info.artistName
        self.smallImageURL = model.artwork.smallUrl
        self.largeImageURL = model.artwork.largeUrl
    }
}

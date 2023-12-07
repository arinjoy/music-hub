import Foundation
import Combine
import DataLayer

// MARK: - UseCase Spy

public final class PlayListUseCaseSpy: PlayListUseCaseType {

    // Spied calls
    public var fetchPlayListCalled: Bool = false

    // Spied values
    public var isMockData: Bool?

    public func fetchCurrentPlayList(isMockData: Bool?) async throws -> [DevicePlay] {
        self.isMockData = isMockData
        fetchPlayListCalled = true
        return []
    }
}

// MARK: - UseCase Mock

public final class PlayListUseCaseMock: PlayListUseCaseType {

    public var returningError: Bool
    public var error: NetworkError
    public var resultingData: [DevicePlay]

    init(
        returningError: Bool = false,
        error: NetworkError = NetworkError.unknown,
        resultingData: [DevicePlay] = PlayListUseCaseMock.samplePlayList
    ) {
        self.returningError = returningError
        self.error = error
        self.resultingData = resultingData
    }

    public func fetchCurrentPlayList(isMockData: Bool?) async throws -> [DevicePlay] {
        if returningError {
            throw error
        }
        return resultingData
    }

    public static var samplePlayList: [DevicePlay] {
        return [
            .init(
                id: 11,
                roomName: "Lounge",
                artwork: .init(
                    smallUrl: URL(string: "url.1-small.com")!,
                    largeUrl: URL(string: "url.1-large.com")!
                ),
                info: .init(trackName: "track name 1", artistName: "artrist name 1")
            ),
            .init(
                id: 22,
                roomName: "Bedroom",
                artwork: .init(
                    smallUrl: URL(string: "url.2-small.com")!,
                    largeUrl: URL(string: "url.2-large.com")!
                ),
                info: .init(trackName: "track name 2", artistName: "artrist name 2")
            )
        ]
    }
}


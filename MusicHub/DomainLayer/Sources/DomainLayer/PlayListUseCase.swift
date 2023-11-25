//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation
import Combine
import DataLayer

public class PlayListUseCase: PlayListUseCaseType {

    // MARK: - Dependency

    private let networkService: NetworkServiceType

    // MARK: - Initializer

    /// NOTE: 🤚🏽 Use the provider which is the default as in below.
    /// During debugging / testing use the `localStubbedProvider()`
    /// not to hit the real network and get locally stubbed mocked JSON :)
    public init(
        networkService: NetworkServiceType = ServicesProvider.defaultProvider().network
    ) {
        self.networkService = networkService
    }

    // MARK: - NextRacesInteracting

    public func fetchCurrentPlayList() async throws -> [DevicePlay] {

        try await networkService.load(
            Resource<DeviceListResponse>.currentDevices()
        )
        .flatMapLatest { [unowned self] devicesResponse in
            networkService.load(
                Resource<NowPlayingMusicListResponse>.nowPlayingList()
            )
            .compactMap { [unowned self] musicListResponse in
                musicListResponse.playList.map {
                    mapDevicePlay(from: $0, deviceList: devicesResponse.devices)
                }
                .compactMap { $0 }
            }
        }
        .eraseToAnyPublisher()
        .async()
    }

    // MARK: - Private Helpers

    private func mapDevicePlay(from music: Music, deviceList: [Device]) -> DevicePlay? {

        guard let matchingDevice = deviceList.first(
            where: { device in
                device.id == music.deviceId
            }
        ) else {
            return nil
        }

        guard
            let smallArtWorkURL = URL(string: music.artworkSmallUrl),
            let largeArtWorkURL = URL(string: music.artworkLargeUrl)
        else {
            return nil
        }

        return .init(
            id: matchingDevice.id,
            roomName: matchingDevice.name,
            artwork: .init(smallUrl: smallArtWorkURL, largeUrl: largeArtWorkURL),
            info: .init(trackName: music.trackName, artistName: music.artistName)
        )
    }

}

private extension AnyPublisher {

    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?

            cancellable = first()
                .sink { result in
                    switch result {
                    case .finished:
                        break
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                } receiveValue: { value in
                    continuation.resume(with: .success(value))
                }
        }
    }
}

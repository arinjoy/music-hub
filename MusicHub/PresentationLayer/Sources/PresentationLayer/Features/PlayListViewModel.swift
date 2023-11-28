//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation
import DomainLayer

class PlayListViewModel: ObservableObject {

    // MARK: - Outputs

    @Published private(set) var playItems: [DevicePlayViewModel] = []

    @Published var currentlyPlayingItem: DevicePlayViewModel?

    // MARK: - Dependency

    private let useCase: PlayListUseCaseType

    // MARK: - Initializer

    init(useCase: PlayListUseCaseType = PlayListUseCase()) {
        self.useCase = useCase
    }

    // MARK: - API methods

    @MainActor
    func fetchLatestRoomsList() async {
        do {
            playItems = try await useCase
                .fetchCurrentPlayList()
                .map { .init(model: $0) }
        } catch {
            // TODO: handle later
        }
    }
}

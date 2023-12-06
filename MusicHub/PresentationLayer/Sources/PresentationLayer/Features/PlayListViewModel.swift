//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation
import DomainLayer

class PlayListViewModel: ObservableObject {

    // MARK: - Outputs

    // A property that play is key differentiator whether demo/mock data or in real-mode
    // is being used currently in the app
    @Published var isMockDataMode: Bool = false

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
                .fetchCurrentPlayList(isMockData: isMockDataMode)
                .map { .init(model: $0) }
        } catch {
            // TODO: handle later
        }
    }
}

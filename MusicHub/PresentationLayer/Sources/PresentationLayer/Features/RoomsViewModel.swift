//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation
import DomainLayer

class RoomsViewModel: ObservableObject {

    // MARK: - Outputs

    @Published private(set) var devicePlayItems: [DevicePlayViewModel] = []

    // MARK: - Dependency

    private let useCase: PlayListUseCaseType

    // MARK: - Initializer

    init(useCase: PlayListUseCase = PlayListUseCase()) {
        self.useCase = useCase
    }

    // MARK: - API methods

    @MainActor
    func fetchLatestRoomsList() async {
        do {
            devicePlayItems = try await useCase
                .fetchCurrentPlayList()
                .map { .init(model: $0) }
        } catch {
            // TODO: handle later
        }
    }
}

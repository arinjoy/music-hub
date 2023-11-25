//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation
import DomainLayer

class RoomsViewModel: ObservableObject {

    // output
    @Published private(set) var rooms: [DevicePlay] = []

    private let useCase: PlayListUseCaseType

    init(useCase: PlayListUseCase = PlayListUseCase()) {
        self.useCase = useCase
    }

    @MainActor
    func fetchLatestRoomsList() async {
        do {
            rooms = try await useCase.fetchCurrentPlayList()
        } catch {
            // TODO: handle later
        }
    }
}

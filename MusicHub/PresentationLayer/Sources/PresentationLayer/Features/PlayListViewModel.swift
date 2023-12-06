import Foundation
import DomainLayer

class PlayListViewModel: ObservableObject {

    enum State {
        case idle
        case loading
        case loaded(items: [DevicePlayViewModel])
        case failed(error: Error)
    }

    enum Selection {
        case none
        case selected(DevicePlayViewModel)
    }

    // MARK: - Outputs

    @Published private(set) var state = State.idle

    @Published private(set) var selection = Selection.none

    @Published var isMockDataMode: Bool = false

    // MARK: - Dependency

    private let useCase: PlayListUseCaseType

    // MARK: - Initializer

    init(useCase: PlayListUseCaseType = PlayListUseCase()) {
        self.useCase = useCase
    }

    // MARK: - API methods

    @MainActor
    func fetchLatestPlayList() async {

        state = .loading

        selection = .none

        do {
            let playItems: [DevicePlayViewModel] = try await useCase
                .fetchCurrentPlayList(isMockData: isMockDataMode)
                .map { .init(model: $0) }

            state = .loaded(items: playItems)
        } catch {
            state = .failed(error: error)
        }
    }

    func applySelection(_ itemID: DevicePlayViewModel.ID?) {
        if case .loaded(let items) = state,
           let item = items.first(where: { $0.id == itemID }) {
            selection = .selected(item)
        } else {
            selection = .none
        }
    }
}

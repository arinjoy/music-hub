import SwiftUI

struct DevicePlayListView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: PlayListViewModel

    @State private var selectedItem: DevicePlayViewModel.ID?

    @State private var viewDidLoad = false

    // MARK: - UI Body

    var body: some View {
        asyncContentView
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    refreshPlayList()
                }
            }
            .onChange(of: selectedItem) { _ in
                viewModel.applySelection(selectedItem)
            }
            .onChange(of: viewModel.isMockDataMode) { _ in
                refreshPlayList()
                selectedItem = nil
            }
    }

    // MARK: - Private

    private func refreshPlayList() {
        Task {
            await viewModel.fetchLatestPlayList()
        }
    }

    @ViewBuilder
    private var asyncContentView: some View {
        switch viewModel.state {
        case .idle:
            // TODO: Improve this logic to blend with view's on appear
            // to make the initial transtion
            Color.clear

        case .loading:
            ProgressView()

        case .failed(let error):
            // TODO: Handle error more elegnantly via its dedciated
            // view and custom messaging
            Text("Oops! Something went wrong in loading.")

        case .loaded(let items):
            List(selection: $selectedItem) {
                ForEach(items) { item in
                    PlayListCellView(
                        viewModel: item,
                        isSelected: Binding(
                            get: { item.id == selectedItem },
                            set: { _ in }
                        )
                    )
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
    }
}

#Preview {
    DevicePlayListView()
}

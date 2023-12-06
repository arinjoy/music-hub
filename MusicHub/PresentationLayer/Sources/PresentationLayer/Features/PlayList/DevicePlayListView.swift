import SwiftUI

struct DevicePlayListView: View {

    @State private var viewDidLoad = false

    @EnvironmentObject private var viewModel: PlayListViewModel

    @State private var selectedItem: DevicePlayViewModel.ID?

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

    private func refreshPlayList() {
        Task {
            await viewModel.fetchLatestPlayList()
        }
    }

    @ViewBuilder
    private var asyncContentView: some View {
        switch viewModel.state {
        case .idle:
            // TODO: Imrpove this logic to blend with view's on appear
            // to make the initial transtion
            Color.clear

        case .loading:
            ProgressView()

        case .failed(let error):
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

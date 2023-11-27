//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

struct RoomsListView: View {

    @ObservedObject private var viewModel: RoomsListViewModel

    @State private var selectedDevice: DevicePlayViewModel.ID?

    init(viewModel: RoomsListViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(selection: $selectedDevice) {
            ForEach(viewModel.devicePlayItems) { item in
                RoomCellView(
                    viewModel: item,
                    isSelected: Binding(
                        get: { item.id == selectedDevice },
                        set: { _ in  }
                    )
                )

            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .onAppear {
            Task {
                await viewModel.fetchLatestRoomsList()
            }
        }
        .onChange(of: selectedDevice) { _ in
            print(selectedDevice ?? "")
        }
    }
}

#Preview {
    RoomsListView()
}

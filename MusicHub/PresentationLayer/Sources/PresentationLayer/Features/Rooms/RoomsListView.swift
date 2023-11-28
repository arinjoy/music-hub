//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

struct RoomsListView: View {

    @EnvironmentObject private var viewModel: PlayListViewModel

    @State private var selectedDevice: DevicePlayViewModel.ID?

//    init(viewModel: RoomsListViewModel = .init()) {
//        self.viewModel = viewModel
//    }

    var body: some View {
        List(selection: $selectedDevice) {
            ForEach(viewModel.playItems) { item in
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
            viewModel.currentlyPlayingItem = viewModel
                .playItems
                .first(where: { $0.id == selectedDevice })
        }
    }
}

#Preview {
    RoomsListView()
}

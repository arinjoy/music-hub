//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

struct RoomsListView: View {

    @EnvironmentObject private var viewModel: PlayListViewModel

    @State private var selectedItem: DevicePlayViewModel.ID?

    var body: some View {
        List(selection: $selectedItem) {
            ForEach(viewModel.playItems) { item in
                RoomCellView(
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
        .onAppear {
            Task {
                await viewModel.fetchLatestRoomsList()
            }
        }
        .onChange(of: selectedItem) { _ in
            viewModel.currentlyPlayingItem = viewModel
                .playItems
                .first(where: { $0.id == selectedItem })
        }
    }
}

#Preview {
    RoomsListView()
}

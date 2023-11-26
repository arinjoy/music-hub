//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

struct RoomsView: View {

    @ObservedObject
    private var viewModel: RoomsViewModel

    init(viewModel: RoomsViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            ForEach(viewModel.devicePlayItems) { item in
                RoomCellView(viewModel: item)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchLatestRoomsList()
            }
        }
    }
}

#Preview {
    RoomsView()
}

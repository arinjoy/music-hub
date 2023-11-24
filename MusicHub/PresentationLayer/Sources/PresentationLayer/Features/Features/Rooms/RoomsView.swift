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
        List(viewModel.rooms) { room in
            Text(room.roomName)
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

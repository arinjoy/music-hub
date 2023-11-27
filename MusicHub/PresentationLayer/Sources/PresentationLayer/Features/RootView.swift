//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

public struct RootView: View {

    // MARK: - Initializer

    public init() {

    }

    // MARK: - UI Body

    @MainActor
    public var body: some View {
        TabView {
            RoomsListView()
                .tabItem {
                    Image(.tabbarIconBlockRooms)
                    Text("Rooms")
                }

            NowPlayingView()
                .tabItem {
                    Image(.tabbarIconNowPlaying)
                    Text("Now Playing")
                }

            SettingsView()
                .tabItem {
                    Image(.tabbarIconSettings)
                    Text("Settings")
                }
        }
        .tint(.teal)
    }
}

#Preview {
    RootView()
}

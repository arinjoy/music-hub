//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

public struct RootView: View {

    // MARK: - Initializer

    public init() {

    }

    // MARK: - UI Body

    public var body: some View {
        TabView {
            roomsView
                .tabItem {
                    Image(.tabbarIconBlockRooms)
                    Text("Rooms")
                }

            nowPlayingView
                .tabItem {
                    Image(.tabbarIconNowPlaying)
                    Text("Now Playing")
                }

            settingsView
                .tabItem {
                    Image(.tabbarIconSettings)
                    Text("Settings")
                }
        }
        .tint(.teal)
    }

    @ViewBuilder
    private var roomsView: some View {
        Text("List of rooms/devices")
    }

    @ViewBuilder
    private var nowPlayingView: some View {
        Text("Settings")
    }

    @ViewBuilder
    private var settingsView: some View {
        Text("Settings")
    }
}

#Preview {
    RootView()
}

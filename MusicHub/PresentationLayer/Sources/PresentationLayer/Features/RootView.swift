//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI
import DomainLayer

public struct RootView: View {


    // MARK: - Initializer

    public init() {

    }

    // MARK: - UI Body
    
    @MainActor
    public var body: some View {
        TabView {
            RoomsView()
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

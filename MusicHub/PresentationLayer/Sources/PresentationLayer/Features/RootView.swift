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

            NowPlayingView(
                viewModel: .init(
                    isPlaying: true,
                    model: .init(
                        id: 1111,
                        roomName: "Bedroom",
                        artwork: .init(
                            smallUrl: URL(string: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg")!,
                            largeUrl: URL(string: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+large.jpg")!
                        ),
                        info: .init(trackName: "Summer of 69", artistName: "Bryan Adams")
                    )
                ),
                isPlaying: .constant(true)
            )
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

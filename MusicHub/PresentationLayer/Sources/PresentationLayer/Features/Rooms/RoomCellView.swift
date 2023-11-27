//
//  Created by Arinjoy Biswas on 25/11/2023.
//

import SwiftUI

struct RoomCellView: View {

    @Binding private var isSelected: Bool

    @ObservedObject
    private var viewModel: DevicePlayViewModel

    init(viewModel: DevicePlayViewModel, isSelected: Binding<Bool>) {
        self.viewModel = viewModel
        self._isSelected = isSelected
    }

    var body: some View {
        ZStack {
            Image(isSelected ? .cellBackgroundSelected : .cellBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            HStack(alignment: .center) {

                Spacer().frame(width: 30)

                artworkThumbnail

                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.roomName)
                        .font(.headline)

                    HStack(alignment: .center, spacing: 0) {
                        playbackStateIcon

                        Text(viewModel.musicTrackName + ", " + viewModel.musicArtistName)
                            .font(.subheadline)
                    }
                }

                Spacer()
            }
        }
        .onChange(of: isSelected) { _ in
            // TODO: remove debugging code
            print("\(viewModel.roomName) --> \(isSelected)")
        }
    }

    @ViewBuilder
    private var artworkThumbnail: some View {
        AsyncImage(url: viewModel.smallImageURL) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray
        }
            .frame(maxWidth: 40, maxHeight: 40)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    @ViewBuilder
    private var playbackStateIcon: some View {
        Image(
            viewModel.isPlaying ?
                .nowPlayingControlsPauseSmall : .nowPlayingControlsPlaySmall
        )
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
    }
}

#Preview {
    VStack {
        RoomCellView(
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
            isSelected: .constant(true)
        )

        RoomCellView(
            viewModel: .init(
                isPlaying: false,
                model: .init(
                    id: 2222,
                    roomName: "Lounge Room",
                    artwork: .init(
                        smallUrl: URL(string: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg")!,
                        largeUrl: URL(string: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+large.jpg")!
                    ),
                    info: .init(trackName: "My heart goes on", artistName: "Sia")
                )
            ),isSelected: .constant(false)
        )
    }
}

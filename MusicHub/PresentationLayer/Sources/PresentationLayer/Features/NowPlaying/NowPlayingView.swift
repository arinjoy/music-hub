//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

struct NowPlayingView: View {

    // MARK: - ViewModel

    @ObservedObject
    private(set) var viewModel: DevicePlayViewModel

    // MARK: - Perivate Properties

    @Binding private var isPlaying: Bool

    @State private var trackProgressValue: Double = 30
    @State private var musicVolumeValue: Double = 70

    // MARK: - Initializer

    init(viewModel: DevicePlayViewModel, isPlaying: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPlaying = isPlaying
    }

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            headerView

            artworkImageView

            trackProgressSliderView

            Spacer().frame(height: 10)

            trackInfoView

            Spacer().frame(height: 10)

            playbackControlsView

            Spacer().frame(height: 10)

            footerView
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - Private Views

private extension NowPlayingView {

    @ViewBuilder
    var headerView: some View {
        Text("This iPhone")
            .font(.title2)
    }

    @ViewBuilder
    var artworkImageView: some View {

        AsyncImage(url: viewModel.largeImageURL) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray
        }
        .frame(maxWidth: 200, maxHeight: 200)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    @ViewBuilder
    var trackProgressSliderView: some View {
        VStack {
            Slider(value: $trackProgressValue, in: 1...100)
                .tint(.primary)

            HStack {
                Text("0.51")
                Spacer()
                Text("-3.01")
            }
        }

    }

    @ViewBuilder
    var trackInfoView: some View {
        VStack {
            Text(viewModel.musicTrackName)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)

            Text(viewModel.musicArtistName)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    var playbackControlsView: some View {
        HStack(spacing: 16) {
            repeatButton
            Spacer()
            playPreviousButton
            Spacer()
            playAndPauseButton
            Spacer()
            playNextButton
            Spacer()
            shuffleButton
        }
    }

    @ViewBuilder
    var playAndPauseButton: some View {
        Button(action: {
            viewModel.isPlaying.toggle()
        }, label: {
            Image(
                viewModel.isPlaying ?
                    .nowPlayingControlsPause : .nowPlayingControlsPlay
            )
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        })
    }

    @ViewBuilder
    var playNextButton: some View {
        Image(systemName: "forward.end")
            .resizable()
            .frame(width: 24, height: 24)
    }

    @ViewBuilder
    var playPreviousButton: some View {
        Image(systemName: "backward.end")
            .resizable()
            .frame(width: 24, height: 24)
    }

    @ViewBuilder
    var shuffleButton: some View {
        Image(systemName: "shuffle")
            .resizable()
            .frame(width: 24, height: 24)
    }

    @ViewBuilder
    var repeatButton: some View {
        Image(systemName: "repeat")
            .resizable()
            .frame(width: 24, height: 24)
    }

    @ViewBuilder
    var muteButton: some View {
        Image(systemName: "speaker.slash.fill")
            .resizable()
            .frame(width: 24, height: 24)
    }

    @ViewBuilder
    var footerView: some View {
        VStack(alignment: .center) {
            HStack {
                muteButton

                Slider(value: $musicVolumeValue, in: 1...100)
                    .tint(.primary)
            }

            Text(viewModel.roomName)
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundStyle(.secondary)
        }
    }

}

#Preview {
    NowPlayingView(
        viewModel: .init(
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
}

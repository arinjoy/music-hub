//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

// swiftlint:disable all
struct SettingsView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: PlayListViewModel

    /// A state that remembers if the Demo-mode mock-data is used currently.
    @State private var isMockDataMode: Bool = false


    /// A helper for dark-mode override
    @AppStorage("isDarkMode") private var isDarkMode = false

    // MARK: - UI body

    // NOTE: Break down the sub section via `@ViewBuilder` based
    // child elements, show that easy to follow declarative code.
    // Otherwise, very hard to follow.

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    demoDataSelectorSection
                        .onChange(of: isMockDataMode) { isMockData in
                            viewModel.isMockDataMode = isMockData
                        }

                    secondSection

                    thirdSection

                    fourthSection

                    fifthSection
                }
                .navigationBarTitle(Text("Settings"), displayMode: .large)
                .padding()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
// swiftlint:disable all

private extension SettingsView {

    @ViewBuilder
    var demoDataSelectorSection: some View {
        GroupBox(
            label: SettingsLabelView(text: "Mock Data", imageName: "cloud.snow")
        ) {

            Divider()
                .padding(.vertical, 4)

            Text(
                "If you like to test the Demo version of this app, without connecting to internet using some mock data, toggle this switch."
            )
                .padding(.vertical, 8)
                .frame(minHeight: 60)
                .layoutPriority(1)
                .font(.footnote)
                .multilineTextAlignment(.leading)

            Toggle(isOn: $isMockDataMode) {
                Text("Demo Mode")
            }
            .padding()
            .background(
              Color(UIColor.tertiarySystemBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            )
        }
    }

    @ViewBuilder
    var secondSection: some View {
        GroupBox(
            label: SettingsLabelView(text: "Music Hub", imageName: "info.circle")
        ) {

            Divider()
                .padding(.vertical, 4)

            HStack(alignment: .center, spacing: 16) {

                // swiftlint:disable:next line_length
                Text("A music hub application to control all your HEOS devices on the go!")
                    .font(.footnote)
            }
            .accessibilityElement(children: .combine)
        }
    }

    @ViewBuilder
    var thirdSection: some View {
        GroupBox(
            label: SettingsLabelView(text: "Customization", imageName: "paintbrush")
        ) {

            Divider()
                .padding(.vertical, 4)

            Text(
                "If you wish, you can update the theme to be dark mode. Also you can update larger accessibility font sizes from system settings and see how the app adapts to it."
            )
                .padding(.vertical, 8)
                .frame(minHeight: 60)
                .layoutPriority(1)
                .font(.footnote)
                .multilineTextAlignment(.leading)

            Toggle(isOn: $isDarkMode) {
                Text("Dark Mode")
            }
            .padding()
            .background(
              Color(UIColor.tertiarySystemBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            )
        }
    }

    @ViewBuilder
    var fourthSection: some View {
        GroupBox(
            label: SettingsLabelView(
                text: "Creator",
                imageName: "person.crop.square.filled.and.at.rectangle"
            )
        ) {
            SettingsRowView(name: "Developer", value: "Arinjoy Biswas")

            SettingsRowView(
                name: "Github",
                linkLabel: "github.com/arinjoy",
                linkURL: URL(string: "https://github.com/arinjoy")!
            )

            SettingsRowView(
                name: "LinkedIn",
                linkLabel: "linkedin.com/arinjoy",
                linkURL: URL(string: "https://www.linkedin.com/in/arinjoybiswas/")!
            )
        }
    }

    @ViewBuilder
    var fifthSection: some View {
        GroupBox(
            label: SettingsLabelView(text: "Application", imageName: "apps.iphone")
        ) {
            SettingsRowView(name: "Compatibility", value: "iOS 16+")
            SettingsRowView(name: "SwiftUI", value: "v4")
            SettingsRowView(name: "App", value: "1.2.1")
        }
    }

}

struct SettingsLabelView: View {

    let text: String
    let imageName: String

    var body: some View {
        HStack {
            Text(text.uppercased())
                .fontWeight(.bold)
                .accessibilityAddTraits(.isHeader)

            Spacer()

            Image(systemName: imageName)
                .accessibilityHidden(true)
        }
        .accessibilityElement(children: .combine)
    }
}

struct SettingsRowView: View {

    var name: String
    var value: String?
    var linkLabel: String?
    var linkURL: URL?

    // MARK: - UI Body

    var body: some View {

        VStack {

              Divider().padding(.vertical, 4)

              HStack {

                Text(name)
                      .foregroundColor(Color.gray)

                Spacer()

                if let value {

                    Text(value)

                } else if let linkLabel, let linkURL {

                    Link(linkLabel, destination: linkURL)
                        .font(.callout)
                        .foregroundColor(.blue)

                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.blue)
                        .accessibilityHidden(true)

                } else {
                    EmptyView()
                }
            }
              .accessibilityElement(children: .combine)
        }
    }
}

#Preview {
    SettingsView()
}

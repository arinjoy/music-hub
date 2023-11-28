//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

// swiftlint:disable all
struct SettingsView: View {

    // MARK: - Properties

    @AppStorage("isDarkMode") private var isDarkMode = false

    // MARK: - UI body

    // NOTE: Break down the sub section via `@ViewBuilder` based
    // child elements, show that easy to follow declarative code.
    // Otherwise, it looks like pyramid of doom with too many
    // nested blocks

    var body: some View {

        NavigationView {

            ScrollView(.vertical, showsIndicators: false) {

                VStack(spacing: 20) {

                    // MARK: - Section 1

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

                    // MARK: - Section 2

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

                    // MARK: - Section 3

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

                    // MARK: - Section 4

                    GroupBox(
                        label: SettingsLabelView(text: "Application", imageName: "apps.iphone")
                    ) {
                        SettingsRowView(name: "Compatibility", value: "iOS 16+")
                        SettingsRowView(name: "SwiftUI", value: "v4")
                        SettingsRowView(name: "App", value: "1.2.1")
                    }


                }
                .navigationBarTitle(Text("Settings"), displayMode: .large)
                .padding()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
// swiftlint:disable all

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

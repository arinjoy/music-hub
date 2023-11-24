//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation

public struct Device: Decodable, Identifiable {
    public let id: Int32
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}

public struct DeviceListResponse: Decodable {
    public let devices: [Device]

    private enum CodingKeys: String, CodingKey {
        case devices = "Devices"
    }
}

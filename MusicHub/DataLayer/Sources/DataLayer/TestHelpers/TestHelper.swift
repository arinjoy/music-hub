//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation

public struct TestHelper {

    public static var sampleDevicesList: DeviceListResponse {
        // swiftlint:disable:next force_try
        return try! JSONDecoder().decode(
            DeviceListResponse.self,
            from: TestHelper.jsonData(forResource: "test_devices_success")
        )
    }

    public static var sampleNowPlayingList: DeviceListResponse {
        // swiftlint:disable:next force_try
        return try! JSONDecoder().decode(
            DeviceListResponse.self,
            from: TestHelper.jsonData(forResource: "test_nowplaying_success")
        )
    }

    public static func jsonData(forResource resource: String) -> Data {
        let fileURLPath = Bundle.module.url(forResource: resource,
                                            withExtension: "json",
                                            subdirectory: "JSON/Mocks")

        // swiftlint:disable:next force_try force_unwrapping
        return try! Data(contentsOf: fileURLPath!)
    }
}

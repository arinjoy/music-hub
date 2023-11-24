//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation

public struct TestHelper {

    public static var sampleDevicesList: DeviceListResponse {
        return try! JSONDecoder().decode(
            DeviceListResponse.self,
            from: TestHelper.jsonData(forResource: "sample_devices_success")
        )
    }

    public static func jsonData(forResource resource: String) -> Data {
        let fileURLPath = Bundle.module.url(forResource: resource,
                                            withExtension: "json",
                                            subdirectory: "JSON/Mocks")

        return try! Data(contentsOf: fileURLPath!)
    }
}
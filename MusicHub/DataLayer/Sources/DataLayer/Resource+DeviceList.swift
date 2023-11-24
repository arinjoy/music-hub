//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation

extension Resource {

    public static func currentDevices() -> Resource<DeviceListResponse> {
        let targetURL = ApiConstants.baseURL.appending(path: "devices.json")
        return Resource<DeviceListResponse>(url: targetURL)
    }

}

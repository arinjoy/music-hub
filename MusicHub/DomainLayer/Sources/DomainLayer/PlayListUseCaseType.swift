//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation
import DataLayer

public protocol PlayListUseCaseType: AnyObject {

    /// Fetches the current list devices which are playing various music.
    /// - Parameter isMockData: An optional boolean to indicate mocking is required or not
    /// - Returns: The list of music/play objects per device
    func fetchCurrentPlayList(isMockData: Bool?) async throws -> [DevicePlay]

}

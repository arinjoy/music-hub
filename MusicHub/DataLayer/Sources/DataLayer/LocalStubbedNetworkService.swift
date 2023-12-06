//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation
import Combine

/// This is a stub implementation of `NetworkServiceType` to fetch data locally from JSON file after 2 seconds delay
final class LocalStubbedDataService: NetworkServiceType {

    // MARK: - NetworkServiceType

    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, NetworkError> {

        var localFileName = ""
        let urlString = resource.url.absoluteString
        if urlString.hasSuffix("devices.json") {
            localFileName = "devices"
        } else if urlString.hasSuffix("nowplaying.json") {
            localFileName = "nowplaying"
        }

        let future = Future<T, NetworkError> { [weak self] promise in
            guard let strongSelf = self else {
                promise(.failure(.unknown))
                return
            }

            if let fileURLPath = Bundle.module.url(
                forResource: localFileName,
                withExtension: "json",
                subdirectory: "JSON"
            ) {

                do {
                    let data = try Data(contentsOf: fileURLPath)
                    let jsonDecoder = JSONDecoder()
                    let decoded = try jsonDecoder.decode(T.self, from: data)
                    promise(.success(decoded))
                } catch {
                    promise(.failure(.jsonDecodingError(error: error)))
                }
            } else {
                promise(.failure(.unknown))
            }
        }
        return future.eraseToAnyPublisher()
    }
}

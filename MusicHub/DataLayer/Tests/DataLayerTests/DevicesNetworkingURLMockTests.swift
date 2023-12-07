import XCTest
import Combine
@testable import DataLayer

// swiftlint:disable force_unwrapping
final class DevicesNetworkingURLMockTests: XCTestCase {

    // MARK: - Properties

    private lazy var sessionConfiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return config
    }()

    private lazy var networkService = NetworkService(with: sessionConfiguration)

    private let resource = Resource<DeviceListResponse>.currentDevices()

    private var cancellables: [AnyCancellable] = []

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        URLProtocol.registerClass(URLProtocolMock.self)
    }

    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        super.tearDown()
    }

    // MARK: - Tests

    func testURLoadingSuccess() {

        // GIVEN
        var response: DeviceListResponse!
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: self.resource.url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, TestHelper.jsonData(forResource: "test_devices_success"))
        }

        // WHEN
        networkService.load(resource)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                response = value
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // THEN
        self.waitForExpectations(timeout: 1.0, handler: nil)

        // There should be 2 devices in the array
        XCTAssertEqual(response.devices.count, 2)
    }

    func testURLoadingFailure500ServerError() {
        var resultingError: NetworkError!

        // GIVEN
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: self.resource.url,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        // WHEN
        networkService.load(resource)
            .sink(receiveCompletion: { completion in
                switch  completion {
                case .failure(let error):
                    resultingError = error
                    expectation.fulfill()
                case .finished: break
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        // THEN
        self.waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertEqual(resultingError, .server)
    }

    func testURLoadingFailure403ForbiddenError() {
        var resultingError: NetworkError!

        // GIVEN
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: self.resource.url,
                statusCode: 403,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        // WHEN
        networkService.load(resource)
            .sink(receiveCompletion: { completion in
                switch  completion {
                case .failure(let error):
                    resultingError = error
                    expectation.fulfill()
                case .finished: break
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        // THEN
        self.waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertEqual(resultingError, .forbidden)
    }

    func testURLLoadingFailureJSONDecodingError() {

        // GIVEN
        var resultingError: NetworkError!
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: self.resource.url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data()) // Empty data
        }

        // WHEN
        networkService.load(resource)
            .sink(receiveCompletion: { completion in
                switch  completion {
                case .failure(let error):
                    resultingError = error
                    expectation.fulfill()
                case .finished: break
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        // THEN
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .jsonDecodingError = resultingError else {
            XCTFail("Must fail with JSON decoding error")
            return
        }
    }

    // TODO: Add more unit tests for various error code mapping
    // to cover the internals of the error mapping of NetworkService

}
// swiftlint:enable force_unwrapping


import XCTest
import Combine
@testable import DataLayer

final class DevicesNetworkingTests: XCTestCase {

    private var cancellables: [AnyCancellable] = []

    // MARK: - Lifecycle

    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        super.tearDown()
    }

    // MARK: - Tests

    func testSpyLoadingResource() throws {

        // GIVEN - network service that is a spy
        let networkServiceSpy = NetworkServiceSpy()

        // WHEN - loading of desired resource type
        _ = networkServiceSpy
            .load(Resource<DeviceListResponse>.currentDevices())

        // THEN - Spying works correctly to see what values are being hit

        // Spied call
        XCTAssertTrue(networkServiceSpy.loadResourceCalled)

        // Spied values
        XCTAssertNotNil(networkServiceSpy.url)
        XCTAssertEqual(
            networkServiceSpy.url?.absoluteString,
            "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/devices.json"
        )

        XCTAssertNotNil(networkServiceSpy.parameters)
        XCTAssertEqual(networkServiceSpy.parameters?.count, 0)

        XCTAssertNotNil(networkServiceSpy.request)
    }

    func testSuccessfulLoading() throws {
        var receivedError: NetworkError?
        var receivedResponse: DeviceListResponse?

        // GIVEN - network service that is a Mock with sample list successfully without error
        let networkServiceMock = NetworkServiceMock(response: TestHelper.sampleDevicesList, returningError: false)

        // WHEN - loading of desired resource type
        networkServiceMock
            .load(Resource<DeviceListResponse>.currentDevices())
            .sink { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                }
            } receiveValue: { response in
                receivedResponse = response
            }
            .store(in: &cancellables)

        // THEN - received devices response should be correct
        XCTAssertNotNil(receivedResponse)
        XCTAssertEqual(receivedResponse?.devices.count, 2)
        XCTAssertEqual(receivedResponse?.devices.first?.id, 111)
        XCTAssertEqual(receivedResponse?.devices.first?.name, "Living Room")

        // AND - there should not any error returned
        XCTAssertNil(receivedError)
    }

    func testFailureLoading() throws {
        var receivedError: NetworkError?
        var receivedResponse: DeviceListResponse?

        // GIVEN - network service that to return an `serviceUnavailable` error
        let networkServiceMock = NetworkServiceMock(
            response: TestHelper.sampleDevicesList,
            returningError: true,
            error: .serviceUnavailable
        )

        // WHEN - loading of desired resource type
        networkServiceMock
            .load(Resource<DeviceListResponse>.currentDevices())
            .sink { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                }
            } receiveValue: { response in
                receivedResponse = response
            }
            .store(in: &cancellables)

        // THEN - there should be an error returned
        XCTAssertNotNil(receivedError)

        // AND - error is correct as type
        XCTAssertEqual(receivedError, .serviceUnavailable)

        // AND - devices response should not be returned
        XCTAssertNil(receivedResponse)
    }
}

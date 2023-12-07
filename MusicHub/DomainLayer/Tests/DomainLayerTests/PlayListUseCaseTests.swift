import XCTest
@testable import DataLayer
@testable import DomainLayer

final class PlayListUseCaseTests: XCTestCase {

    private var useCase: PlayListUseCaseType!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        // Dependency injection to have the stubbed provider
        // that returns sample response as stubbed way from
        // DataLayer's service implementation

        useCase = PlayListUseCase(
            networkService: ServicesProvider.localStubbedProvider().network
        )
    }

    override func tearDown() {
        useCase = nil

        super.tearDown()
    }

    // MARK: - Tests

    @MainActor
    func testCallingServiceSpy() async throws {

        let serviceSpy = NetworkServiceSpy()
        useCase = PlayListUseCase(networkService: serviceSpy)

        // GIVEN - network service that is a spy


        // WHEN - being requested to load playlist
        let reponse = try await useCase.fetchCurrentPlayList(isMockData: nil)

        // THEN - Spying works correctly to see what values are being hit

        // Spied call
        XCTAssertTrue(serviceSpy.loadResourceCalled)

        // Spied values
        XCTAssertNotNil(serviceSpy.url)
    }

    @MainActor
    func testFetchingSuccess() async throws {
        var receivedError: NetworkError?
        var receivedResponse: [DevicePlay]?

        // GIVEN - the usecase is made out of service mock that returns sample playlist
        let serviceMock = NetworkServiceMock(
            response: TestHelper.sampleDevicesList,
            returningError: false
        )
        useCase = PlayListUseCase(networkService: serviceMock)

        // WHEN
        do {
            receivedResponse = try await useCase.fetchCurrentPlayList(isMockData: nil)
        } catch {
            receivedError = error as? NetworkError
        }

        // THEN
        XCTAssertEqual(receivedResponse?.count, 3)

        XCTAssertNil(receivedError)
    }
}

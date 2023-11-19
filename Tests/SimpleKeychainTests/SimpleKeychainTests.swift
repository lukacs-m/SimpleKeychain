import XCTest
@testable import SimpleKeychain

final class SimpleKeychainTests: XCTestCase {
    let keychain = SimpleKeychain()
let key = "ApiToken"
    func testExample() async throws {
        let apiToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJnb2Fsc2J1ZGR5IiwiZXhwIjo2NDA5MjIxMTIwMH0.JoDuSMARI2Ihh8fisiUxfQiP8AE_WFz9Hcogkk8QMcQ"
        try await keychain.set(apiToken, for: key)
        let token: String = try await keychain.get(key: key)

        XCTAssertEqual(token, apiToken)

        try await keychain.set("new-token-value", for: key)
        let newToken: String = try await keychain.get(key: key)

        XCTAssertEqual(newToken, "new-token-value")
        try await keychain.delete(key)

        do {
            try await keychain.get(key: key) as String
            XCTFail("Error needs to be thrown")
        } catch {
            XCTAssertEqual(error as! SimpleKeychainError, SimpleKeychainError.itemNotFound)
        }
    }
}

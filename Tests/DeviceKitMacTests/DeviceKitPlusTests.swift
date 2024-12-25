@testable import DeviceKitMac
import XCTest

final class DeviceKitMacTests: XCTestCase {
    func testExample() throws {
        let deviceName = DeviceKitMac.deviceName()
        let productName = DeviceKitMac.productName
        let productVersion = DeviceKitMac.productVersion
        let productBuildVersion = DeviceKitMac.productBuildVersion
        let serialNumber = DeviceKitMac.serialNumber

        print("deviceName: \(deviceName)")
        print("productName: \(productName ?? "unknown")")
        print("productVersion: \(productVersion ?? "unknown")")
        print("productBuildVersion: \(productBuildVersion ?? "unknown")")
        print("serialNumber: \(serialNumber ?? "unknown")")
    }
}

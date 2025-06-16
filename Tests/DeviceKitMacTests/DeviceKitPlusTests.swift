@testable import DeviceKitMac
import XCTest

final class DeviceKitMacTests: XCTestCase {
    func testExample() throws {
        let deviceName = DeviceKitMac.deviceName()
        let productName = DeviceKitMac.productName
        let productVersion = DeviceKitMac.productVersion
        let productBuildVersion = DeviceKitMac.productBuildVersion
        let serialNumber = DeviceKitMac.serialNumber
        let computerName = DeviceKitMac.computerName

        print("deviceName: \(deviceName)")
        print("productName: \(productName ?? "unknown")")
        print("productVersion: \(productVersion ?? "unknown")")
        print("productBuildVersion: \(productBuildVersion ?? "unknown")")
        print("serialNumber: \(serialNumber ?? "unknown")")
        print("computerName: \(computerName ?? "unknown")")
    }
}

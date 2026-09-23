@testable import DeviceKitMac
import Darwin
import Foundation
import IOKit
import Testing

#if canImport(SystemConfiguration)
    import SystemConfiguration
#endif

@Suite("Host system information")
struct SystemInformationTests {
    @Test("Resolves the current host's model")
    func hostDeviceName() throws {
        // Read the raw model independently, then verify the public API uses its mapping.
        var size = 0
        let sizeResult = sysctlbyname("hw.model", nil, &size, nil, 0)
        try #require(sizeResult == 0)
        try #require(size > 0)
        var bytes = [UInt8](repeating: 0, count: size)
        let readResult = sysctlbyname("hw.model", &bytes, &size, nil, 0)
        try #require(readResult == 0)
        let identifier = try #require(String(bytes: bytes.prefix { $0 != 0 }, encoding: .utf8))
        #expect(!identifier.isEmpty)
        #expect(DeviceKitMac.deviceName() == DeviceKitMac.deviceName(forModelIdentifier: identifier))
        #expect(DeviceKitMac.deviceName(code: "hw.model") == DeviceKitMac.deviceName())
    }

    @Test("Returns an empty name for invalid sysctl keys", arguments: [
        "", "devicekitmac.nonexistent", "Mac17,2",
    ])
    func invalidSystemKey(key: String) {
        #expect(DeviceKitMac.deviceName(code: key).isEmpty)
    }

    @Test("Accepts a sysctl key that is not a model identifier")
    func customSystemKey() {
        #expect(DeviceKitMac.deviceName(code: "kern.ostype") == "Darwin")
    }

    @Test("Reports the macOS product name")
    func productName() throws {
        let name = try #require(DeviceKitMac.productName)
        // Older supported systems can use the previous product name.
        #expect(["macOS", "Mac OS X"].contains(name))
    }

    @Test("System version agrees with ProcessInfo")
    func productVersion() throws {
        let version = try #require(DeviceKitMac.productVersion)
        let components = version.split(separator: ".", omittingEmptySubsequences: false)
        try #require((2...3).contains(components.count))
        let numbers = components.compactMap { Int($0) }
        try #require(numbers.count == components.count)
        let expected = ProcessInfo.processInfo.operatingSystemVersion
        #expect(numbers[0] == expected.majorVersion)
        #expect(numbers[1] == expected.minorVersion)
        #expect((numbers.count == 3 ? numbers[2] : 0) == expected.patchVersion)
    }

    @Test("Build version agrees with the kernel")
    func productBuildVersion() throws {
        let build = try #require(DeviceKitMac.productBuildVersion)
        #expect(!build.isEmpty)
        #expect(build == DeviceKitMac.deviceName(code: "kern.osversion"))
    }

    @Test("Platform UUID is stable and valid when available")
    func platformUUID() throws {
        let value = DeviceKitMac.platformUUID
        // Assert booleans so a failure cannot include the host's identifier.
        let matchesRegistry = value == (try platformProperties()?[kIOPlatformUUIDKey] as? String)
        #expect(matchesRegistry)
        let isStable = value == DeviceKitMac.platformUUID
        #expect(isStable)
        if let value {
            let isValid = UUID(uuidString: value) != nil
            #expect(isValid)
        }
    }

    @Test("Serial number is stable and nonempty when available")
    func serialNumber() throws {
        let value = DeviceKitMac.serialNumber
        let matchesRegistry = value == (try platformProperties()?[kIOPlatformSerialNumberKey] as? String)
        #expect(matchesRegistry)
        let isStable = value == DeviceKitMac.serialNumber
        #expect(isStable)
        if let value {
            let isNonempty = !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            #expect(isNonempty)
        }
    }

    #if canImport(SystemConfiguration)
        @Test("Computer name agrees with SystemConfiguration")
        func computerName() {
            let expected = SCDynamicStoreCopyComputerName(nil, nil) as? String
            let matchesSystemName = DeviceKitMac.computerName == expected
            #expect(matchesSystemName)
        }
    #endif

    /// Read the full registry dictionary to check optional properties without assuming
    /// that every physical Mac or virtual machine exposes a serial number and UUID.
    private func platformProperties() throws -> [String: Any]? {
        let mainPort: mach_port_t
        if #available(macOS 12.0, *) {
            mainPort = kIOMainPortDefault
        } else {
            mainPort = kIOMasterPortDefault
        }
        let service = IOServiceGetMatchingService(mainPort, IOServiceMatching("IOPlatformExpertDevice"))
        guard service != IO_OBJECT_NULL else { return nil }
        defer { IOObjectRelease(service) }
        var properties: Unmanaged<CFMutableDictionary>?
        let result = IORegistryEntryCreateCFProperties(service, &properties, kCFAllocatorDefault, 0)
        try #require(result == KERN_SUCCESS)
        let dictionary = properties?.takeRetainedValue() as? [String: Any]
        let hasDictionary = dictionary != nil
        try #require(hasDictionary)
        return dictionary
    }
}

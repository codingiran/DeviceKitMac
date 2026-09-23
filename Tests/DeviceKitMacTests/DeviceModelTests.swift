@testable import DeviceKitMac
import Testing

@Suite("Device model names")
struct DeviceModelTests {
    @Test("Maps Intel and Apple Silicon models across Mac families", arguments: [
        ("Macmini6,1", "Mac Mini Late 2012"),
        ("Macmini6,2", "Mac Mini Late 2012"),
        ("Macmini9,1", "Mac Mini M1 2020"),
        ("Mac16,10", "Mac Mini M4 2024"),
        ("Mac16,11", "Mac Mini M4 Pro 2024"),
        ("MacBookAir8,1", "MacBook Air Retina 2018 13inch"),
        ("Mac14,2", "MacBook Air M2 2022"),
        ("Mac16,12", "MacBook Air M4 2025 13inch"),
        ("Mac16,13", "MacBook Air M4 2025 15inch"),
        ("MacBook10,1", "MacBook Mid 2017"),
        ("MacBookPro9,1", "MacBook Pro Mid 2012"),
        ("MacBookPro10,1", "MacBook Pro Retina Mid 2012"),
        ("MacBookPro18,1", "MacBook Pro Retina 2021 16inch"),
        ("MacBookPro18,2", "MacBook Pro Retina 2021 16inch"),
        ("Mac15,8", "MacBook Pro 14inch M3 Max"),
        ("Mac15,10", "MacBook Pro 14inch M3 Max"),
        ("Mac16,5", "MacBook Pro 16inch M4 Max"),
        ("Mac17,2", "MacBook Pro 14inch M5"),
        ("iMac13,1", "iMac Late 2012"),
        ("iMac19,1", "iMac Retina 5k 2019 27inch"),
        ("Mac16,2", "iMac M4 2024 24inch"),
        ("Mac16,3", "iMac M4 2024 24inch"),
        ("iMacPro1,1", "iMac Pro 2017"),
        ("MacPro6,1", "Mac Pro Late 2013"),
        ("Mac14,8", "Mac Pro 2023"),
        ("Mac13,1", "Mac Studio M1 Max 2022"),
        ("Mac15,14", "Mac Studio M3 Ultra 2025"),
        ("Mac16,9", "Mac Studio M4 Max 2025"),
    ])
    func knownModel(identifier: String, expectedName: String) {
        #expect(DeviceKitMac.deviceName(forModelIdentifier: identifier) == expectedName)
    }

    // Sources and the Mac mini / Mac Studio identifier discrepancy are documented
    // in Documentation/DeviceModels.md. Keep the Pro/Max and 15/16 identifiers distinct.
    @Test("Maps the 2026 Mac additions", arguments: [
        ("Mac18,5", "Mac Mini M6 2026"),
        ("Mac17,16", "Mac Mini M5 Pro 2026"),
        ("Mac17,3", "MacBook Air M5 2026 13inch"),
        ("Mac17,4", "MacBook Air M5 2026 15inch"),
        ("Mac17,5", "MacBook Neo A18 Pro 2026"),
        ("Mac17,9", "MacBook Pro 14inch M5 Pro"),
        ("Mac17,7", "MacBook Pro 14inch M5 Max"),
        ("Mac17,8", "MacBook Pro 16inch M5 Pro"),
        ("Mac17,6", "MacBook Pro 16inch M5 Max"),
        ("Mac17,14", "Mac Studio M5 Max 2026"),
        ("Mac17,15", "Mac Studio M5 Ultra 2026"),
    ])
    func modelsIntroducedIn2026(identifier: String, expectedName: String) {
        #expect(DeviceKitMac.deviceName(forModelIdentifier: identifier) == expectedName)
    }

    @Test("Preserves unknown identifiers exactly", arguments: [
        "Mac999,1", "Mac17,99", "Mac18,99", "VirtualMac1,1", "", "mac17,2", " Mac17,2 ", "未知机型",
    ])
    func unknownModel(identifier: String) {
        #expect(DeviceKitMac.deviceName(forModelIdentifier: identifier) == identifier)
    }
}

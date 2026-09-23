# DeviceKitMac

[![Swift](https://img.shields.io/badge/Swift-5.10+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](https://www.apple.com/macos/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

DeviceKitMac is a Swift package that provides a simple way to identify and gather information about the macOS device your app is running on. It helps you access system information such as device model, system version, computer name, and more.

## Requirements

- macOS 10.15+
- Swift 5.10+

## Installation

### Swift Package Manager

DeviceKitMac is available through [Swift Package Manager](https://swift.org/package-manager/). To install it, simply add the following line to the dependencies in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/codingiran/DeviceKitMac.git", from: "1.0.5")
]
```

## Usage

```swift
import DeviceKitMac

// Get device model name
let deviceName = DeviceKitMac.deviceName() // e.g., "MacBook Pro 14inch M3"

// Get system version information
let productName = DeviceKitMac.productName // e.g., "macOS"
let productVersion = DeviceKitMac.productVersion // e.g., "14.0"
let buildVersion = DeviceKitMac.productBuildVersion // e.g., "23A344"

// Get device identifiers
let platformUUID = DeviceKitMac.platformUUID
let serialNumber = DeviceKitMac.serialNumber

// Get computer name (if SystemConfiguration is available)
let computerName = DeviceKitMac.computerName
```

## Features

- Device model identification
- System version information
- Platform UUID and serial number access
- Computer name retrieval
- No external dependencies
- Thread-safe operations

### Device model coverage

The model table was last checked on September 23, 2026, adding M5 MacBook Air,
M5 Pro/Max MacBook Pro, MacBook Neo, M6/M5 Pro Mac mini, and M5 Max/Ultra Mac Studio.
See [Device Model Updates](Documentation/DeviceModels.md) for identifiers, sources,
and a documented Mac mini / Mac Studio discrepancy in Apple's identification pages.
Unknown model identifiers are returned unchanged.

## Contributing

Contributions are welcome! Please read the [Repository Guidelines](AGENTS.md) before submitting a pull request.

### Testing

Run the tests on macOS using Swift Package Manager:

```sh
swift test
swift test --enable-code-coverage
```

The tests use Swift Testing (`@Suite`, `@Test`, `#expect`, and `#require`). Swift 6+
includes Testing in its toolchain and needs no package dependency. The Swift 5.10
manifest pins the test-only `swift-testing` dependency to `0.6.0` and uses its
XCTest discovery bridge; all test assertions remain in Swift Testing. The library
itself has no external runtime dependencies.

- `DeviceModelTests` checks representative Intel and Apple Silicon models,
  aliases, and exact fallback behavior for unknown identifiers without accessing hardware.
- `SystemInformationTests` checks the host's model, invalid sysctl keys, system
  version, build number, UUID, serial number, and computer name. Optional hardware
  identifiers are compared with the registry and may be absent on virtual machines.
  Assertions do not print UUIDs, serial numbers, or computer names.

With Swift 6+, run a single suite using `swift test --filter DeviceModelTests` or
`swift test --filter SystemInformationTests`. Swift 5.10 runs both suites through
the bridge's `testAll` entry point. When adding a model, add a matching identifier
and expected display name to the parameterized model test.

## License

DeviceKitMac is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

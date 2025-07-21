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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. Make sure to read the [Contributing Guidelines](CONTRIBUTING.md) first.

## License

DeviceKitMac is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

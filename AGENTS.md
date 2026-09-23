# Repository Guidelines

## Project Structure & Module Organization

DeviceKitMac is a Swift library for macOS 10.15+, supporting Swift 5.10+, with no external runtime dependencies.

- `Sources/DeviceKitMac/DeviceKitMac.swift` contains the public `DeviceKitMac` namespace, system information accessors, and hardware-model mappings.
- `Tests/DeviceKitMacTests/` contains Swift Testing model and system-information suites, plus a Swift 5.10 discovery bridge.
- `Package.swift` uses Swift 6's bundled Testing; `Package@swift-5.10.swift` pins the test-only `swift-testing` dependency to `0.6.0`. Keep products and platform requirements consistent.
- `README.md` documents installation and API usage. There are no application targets or bundled assets.

## Build, Test, and Development Commands

Run commands from the repository root on macOS with Xcode or the Swift command-line tools installed:

- `swift build` — compile the library in debug configuration.
- `swift build -c release` — verify an optimized build.
- `swift test` — build and run all tests.
- `swift test --filter DeviceModelTests` — run model tests on Swift 6+.
- `swift test --enable-code-coverage` — run tests and collect coverage.
- `open Package.swift` — open the package in Xcode for development.

This package exposes a library, so there is no `swift run` executable. For compatibility changes, validate with both Swift 5.10 and Swift 6 toolchains when available.

## Coding Style & Naming Conventions

Use four-space indentation, `UpperCamelCase` for types, and `lowerCamelCase` for properties and functions. Follow the existing `public extension DeviceKitMac` organization and `// MARK:` sections. Group new model identifiers by Mac family and match neighboring display-name conventions. Preserve the raw-identifier fallback for unknown models.

Keep compiler checks and macOS availability guards compatible with supported versions. No formatter or linter is configured; match surrounding code and avoid unrelated formatting changes.

## Testing Guidelines

Use Swift Testing with descriptive `@Test` methods, `#expect`, and `#require`. Add parameterized identifier/name pairs for new models. Keep mapping tests independent of hardware; compare integration results with host APIs. Assert booleans for UUIDs, serial numbers, and computer names to avoid exposing them in failures. Swift 5.10 uses an XCTest bridge only for discovery. No coverage threshold is configured.

## Commit & Pull Request Guidelines

History uses short, direct subjects such as `add computerName and swift6` and `release 1.0.6`; no Conventional Commits scheme is established. Keep commits focused. Pull requests should explain the behavior change, link relevant issues, and report validation commands and toolchain versions. For new hardware mappings, include the identifier, display name, and supporting reference. Update README examples when public API usage changes.

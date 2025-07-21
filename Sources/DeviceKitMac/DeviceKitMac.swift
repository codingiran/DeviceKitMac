//
//  DeviceKitMac.swift
//  DeviceKitMac
//
//  Created by iran.qiu on 2024/11/13.
//

import Foundation

// Enforce minimum Swift version for all platforms and build systems.
#if swift(<5.10)
    #error("DeviceKitMac doesn't support Swift versions below 5.10")
#endif

/// Current DeviceKitMac version 1.0.5. Necessary since SPM doesn't use dynamic libraries. Plus this will be more accurate.
let version = "1.0.5"

public enum DeviceKitMac: Sendable {}

// MARK: - System Version

public extension DeviceKitMac {
    #if compiler(>=6)
        nonisolated(unsafe) static let sysVersionDict = NSDictionary(contentsOfFile: "/System/Library/CoreServices/SystemVersion.plist")
    #else
        static let sysVersionDict = NSDictionary(contentsOfFile: "/System/Library/CoreServices/SystemVersion.plist")
    #endif

    static var productName: String? {
        guard let sys = sysVersionDict else { return nil }
        let productName = sys["ProductName"] as? String
        return productName
    }

    static var productVersion: String? {
        guard let sys = sysVersionDict else { return nil }
        let productVersion = sys["ProductVersion"] as? String
        return productVersion
    }

    static var productBuildVersion: String? {
        guard let sys = sysVersionDict else { return nil }
        let productBuildVersion = sys["ProductBuildVersion"] as? String
        return productBuildVersion
    }
}

// MARK: - Device

public extension DeviceKitMac {
    static func deviceName(code: String = "hw.model") -> String {
        var size = 0
        sysctlbyname(code, nil, &size, nil, 0)
        var model = [CChar](repeating: 0, count: Int(size))
        sysctlbyname(code, &model, &size, nil, 0)

        let device = String(utf8String: model) ?? ""
        switch device {
        /*** Mac Mini ***/
        case "Macmini6,1", "Macmini6,2": return "Mac Mini Late 2012"
        case "Macmini7,1": return "Mac Mini Late 2014"
        case "Macmini8,1": return "Mac Mini Late 2018"
        case "Macmini9,1": return "Mac Mini M1 2020"
        case "Mac14,3": return "Mac Mini M2 2023"
        case "Mac14,12": return "Mac Mini M2 Pro 2023"
        case "Mac16,10": return "Mac Mini M4 2024"
        case "Mac16,11": return "Mac Mini M4 Pro 2024"
        /*** MacBook Air ***/
        case "MacBookAir5,1", "MacBookAir5,2": return "MacBook Air Mid 2012"
        case "MacBookAir6,1", "MacBookAir6,2": return "MacBook Air Mid 2013 and Early 2014"
        case "MacBookAir7,1", "MacBookAir7,2": return "MacBook Air Early 2015"
        case "MacBookAir8,1": return "MacBook Air Retina 2018 13inch"
        case "MacBookAir8,2": return "MacBook Air Retina 2019 13inch"
        case "MacBookAir9,1": return "MacBook Air Retina 2020 13inch"
        case "MacBookAir10,1": return "MacBook Air Late 2020"
        case "Mac14,2": return "MacBook Air M2 2022"
        case "Mac14,15": return "MacBook Air M2 2023 15inch"
        case "Mac15,12": return "MacBook Air M3 2024 13inch"
        case "Mac15,13": return "MacBook Air M3 2024 15inch"
        case "Mac16,12": return "MacBook Air M4 2025 13inch"
        case "Mac16,13": return "MacBook Air M4 2025 15inch"
        /*** MacBook ***/
        case "MacBook8,1": return "MacBook Mid 2017"
        case "MacBook9,1": return "MacBook Mid 2017"
        case "MacBook10,1": return "MacBook Mid 2017"
        /*** MacBook Pro ***/
        case "MacBookPro6,1", "MacBookPro6,2", "MacBookPro6,3": return "MacBook Pro Mid 2010"
        case "MacBookPro8,1", "MacBookPro8,2", "MacBookPro8,3": return "MacBook Pro Mid 2011"
        case "MacBookPro9,1", "MacBookPro9,2": return "MacBook Pro Mid 2012"
        /*** MacBook Pro Retina ***/
        case "MacBookPro10,1": return "MacBook Pro Retina Mid 2012"
        case "MacBookPro10,2": return "MacBook Pro Retina Late 2012"
        case "MacBookPro11,1", "MacBookPro11,2", "MacBookPro11,3": return "MacBook Pro Retina Mid 2014"
        case "MacBookPro12,1": return "MacBook Pro Retina Early 2015"
        case "MacBookPro11,4", "MacBookPro11,5": return "MacBook Pro Retina Mid 2015"
        case "MacBookPro13,1", "MacBookPro13,2", "MacBookPro13,3": return "MacBook Pro Retina Late 2016"
        case "MacBookPro14,1", "MacBookPro14,2", "MacBookPro14,3": return "MacBook Pro Retina Mid 2017"
        case "MacBookPro15,1", "MacBookPro15,3": return "MacBook Pro Retina 2018 or 2019 15inch"
        case "MacBookPro15,2", "MacBookPro15,4": return "MacBook Pro Retina 2018 or 2019 13inch"
        case "MacBookPro16,1", "MacBookPro16,4": return "MacBook Pro Retina 2019 16inch"
        case "MacBookPro16,2", "MacBookPro16,3": return "MacBook Pro Retina 2020 13inch"
        case "MacBookPro17,1": return "MacBook Pro Retina M1 2020 13inch"
        case "MacBookPro18,2", "MacBookPro18,1": return "MacBook Pro Retina 2021 16inch"
        case "MacBookPro18,3", "MacBookPro18,4": return "MacBook Pro Retina 2021 14inch"
        case "Mac14,7": return "MacBook Pro Retina 2022 13inch"
        case "Mac14,5", "Mac14,9": return "MacBook Pro Retina 2023 14inch"
        case "Mac14,6", "Mac14,10": return "MacBook Pro Retina 2023 16inch"
        case "Mac15,3": return "MacBook Pro 14inch M3"
        case "Mac15,6": return "MacBook Pro 14inch M3 Pro"
        case "Mac15,8", "Mac15,10": return "MacBook Pro 14inch M3 Max"
        case "Mac15,7": return "MacBook Pro 16inch M3 Pro"
        case "Mac15,9", "Mac15,11": return "MacBook Pro 16inch M3 Max"
        case "Mac16,1": return "MacBook Pro 14inch M4"
        case "Mac16,8": return "MacBook Pro 14inch M4 Pro"
        case "Mac16,6": return "MacBook Pro 14inch M4 Max"
        case "Mac16,7": return "MacBook Pro 16inch M4 Pro"
        case "Mac16,5": return "MacBook Pro 16inch M4 Max"
        /*** iMac ***/
        case "iMac13,1", "iMac13,2": return "iMac Late 2012"
        case "iMac14,1", "iMac14,2": return "iMac Late 2013"
        case "iMac14,4": return "iMac Mid 2014"
        case "iMac16,1": return "iMac Late 2015"
        case "iMac18,1": return "iMac 2017"
        case "Mac15,4", "Mac15,5": return "iMac M3 2023 24inch"
        case "Mac16,2", "Mac16,3": return "iMac M4 2024 24inch"
        /*** iMac Retina ***/
        case "iMac15,1": return "iMac Retina Late 2014"
        case "iMac16,2", "iMac17,1": return "iMac Retina Late 2015"
        case "iMac18,2", "iMac18,3": return "iMac Retina Min 2017"
        case "iMac19,1": return "iMac Retina 5k 2019 27inch"
        case "iMac19,2": return "iMac Retina 4k 2019 21.5inch"
        case "iMac20,2", "iMac20,1": return "iMac Retina 2020 27inch"
        case "iMac21,2", "iMac21,1": return "iMac M1 2021 24inch"
        /*** iMac Pro ***/
        case "iMacPro1,1": return "iMac Pro 2017"
        /*** Mac Pro ***/
        case "MacPro4,1": return "Mac Pro Early 2009"
        case "MacPro5,1": return "Mac Pro Mid 2012"
        case "MacPro6,1": return "Mac Pro Late 2013"
        case "MacPro7,1": return "Mac Pro Early 2017"
        case "Mac14,8": return "Mac Pro 2023"
        /*** Mac Studio ***/
        case "Mac13,1": return "Mac Studio M1 Max 2022"
        case "Mac13,2": return "Mac Studio M1 Ultra 2022"
        case "Mac14,13": return "Mac Studio M2 Max 2023"
        case "Mac14,14": return "Mac Studio M2 Ultra 2023"
        case "Mac15,14": return "Mac Studio M3 Ultra 2025"
        case "Mac16,9": return "Mac Studio M4 Max 2025"
        /*** Unknown ***/
        default: return device
        }
    }
}

// MARK: - UUID

public extension DeviceKitMac {
    static var platformUUID: String? {
        let mainPort: mach_port_t
        if #available(macOS 12.0, *) {
            mainPort = kIOMainPortDefault
        } else {
            mainPort = kIOMasterPortDefault
        }
        let service = IOServiceGetMatchingService(mainPort, IOServiceMatching("IOPlatformExpertDevice"))
        let uuid = IORegistryEntryCreateCFProperty(service, kIOPlatformUUIDKey as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? String
        IOObjectRelease(service)
        return uuid
    }

    static var serialNumber: String? {
        let mainPort: mach_port_t
        if #available(macOS 12.0, *) {
            mainPort = kIOMainPortDefault
        } else {
            mainPort = kIOMasterPortDefault
        }
        let service = IOServiceGetMatchingService(mainPort, IOServiceMatching("IOPlatformExpertDevice"))
        let serial = IORegistryEntryCreateCFProperty(service, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? String
        IOObjectRelease(service)
        return serial
    }
}

#if canImport(SystemConfiguration)

    import SystemConfiguration

    // MARK: - Computer Name

    public extension DeviceKitMac {
        static var computerName: String? {
            guard let deviceName = SCDynamicStoreCopyComputerName(nil, nil) as? String else { return nil }
            return deviceName
        }
    }

#endif

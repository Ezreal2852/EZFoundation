//
//  UIDevice.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

fileprivate let kDeviceId = "ez_devieId"
fileprivate let kOrientation = "orientation"

public extension UIDevice {
    
    /// 是全面屏吗？
    static var ez_isX: Bool {
        if #available(iOS 11.0.0, *) {
            if let safeAreaInsets = UIApplication.ez_keyWindow?.safeAreaInsets, safeAreaInsets.bottom > 0 {
                return true
            }
        }
        return false
    }
    
    /// 是4寸屏吗？
    static var ez_is4inch: Bool {
        let size = UIScreen.main.bounds.size
        return min(size.width, size.height) <= 320
    }
    
    /// 设备id，app每次安装唯一
    static var ez_devieId: String {
        if let id = UserDefaults.standard.string(forKey: kDeviceId) {
            return id
        }
        let id = NSUUID().uuidString
        UserDefaults.standard.set(id, forKey: kDeviceId)
        UserDefaults.standard.synchronize()
        return id
    }
    
    /// 是模拟器吗？
    static var ez_isSimulator: Bool {
        var isSimulator: Bool = false
        #if arch(i386) || arch(x86_64)
        isSimulator = true
        #endif
        return isSimulator
    }
    
    /// IP地址
    static var ez_ipAddress: String? {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first
    }
    
    /// 设备型号
    static var ez_modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        // iPod
        case "iPod1,1":                                  return "iPod touch"
        case "iPod2,1":                                  return "iPod touch 2"
        case "iPod3,1":                                  return "iPod touch 3"
        case "iPod4,1":                                  return "iPod touch 4"
        case "iPod5,1":                                  return "iPod Touch 5"
        case "iPod7,1":                                  return "iPod Touch 6"
        // iPhone
        case "iPhone1,1":                                return "iPhone"
        case "iPhone1,2":                                return "iPhone 3G"
        case "iPhone2,1":                                return "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return "iPhone 4"
        case "iPhone4,1":                                return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                   return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                   return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                   return "iPhone 5s"
        case "iPhone7,2":                                return "iPhone 6"
        case "iPhone7,1":                                return "iPhone 6 Plus"
        case "iPhone8,1":                                return "iPhone 6s"
        case "iPhone8,2":                                return "iPhone 6s Plus"
        case "iPhone8,4":                                return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":                   return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                   return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                 return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                 return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                 return "iPhone X"
        case "iPhone11,2":                               return "iPhone XS"
        case "iPhone11,4","iPhone11,6":                  return "iPhone XS Max"
        case "iPhone11,8":                               return "iPhone XR"
        case "iPhone12,1":                               return "iPhone 11"
        case "iPhone12,3":                               return "iPhone 11 Pro"
        case "iPhone12,5":                               return "iPhone 11 Pro Max"
        // iPad
        case "iPad1,1":                                  return "iPad"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":            return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":            return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":            return "iPad Air"
        case "iPad5,3", "iPad5,4":                       return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":            return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":            return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":            return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                       return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                       return "iPad Pro (12.9-inch)"
        case "iPad6,3", "iPad6,4":                       return "iPad Pro (9.7-inch)"
        case "iPad6,11", "iPad6,12":                     return "iPad 5"
        case "iPad7,1", "iPad7,2":                       return "iPad Pro (12.9-inch) 2"
        case "iPad7,3", "iPad7,4":                       return "iPad Pro (10.5-inch)"
        case "iPad7,5", "iPad7,6":                       return "iPad 6"
        // AppleTV
        case "AppleTV5,3":                               return "Apple TV"
        // Other
        case "i386", "x86_64":                           return "Simulator"
        default:                                         return identifier
        }
    }
    
    /**
     强制旋屏
     若未生效 请检查
     info.plist -> Supported interface orientations
     UIApplicationDelegate -> supportedInterfaceOrientationsFor
     */
    static func ez_setOrientation(_ orientation: UIInterfaceOrientation) {
        current.setValue(Int(UIInterfaceOrientation.unknown.rawValue), forKey: kOrientation)
        current.setValue(Int(orientation.rawValue), forKey: kOrientation)
    }
}

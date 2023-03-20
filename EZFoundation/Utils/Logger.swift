//
//  Logger.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/2/17.
//
//  dependency "CocoaLumberjack/Swift", '~> 3.7.4'

#if canImport(CocoaLumberjack)

import CocoaLumberjack

public func logVerbose(_ items: Any..., separator: String = " ") { Logger.verbose(items, separator: separator) }
public func logDebug(_ items: Any..., separator: String = " ") { Logger.debug(items, separator: separator) }
public func logInfo(_ items: Any..., separator: String = " ") { Logger.info(items, separator: separator) }
public func logWarning(_ items: Any..., separator: String = " ") { Logger.warning(items, separator: separator) }
public func logError(_ items: Any..., separator: String = " ") { Logger.error(items, separator: separator) }

@objc public enum LogLevel: Int {
    case off
    case verbose
    case debug
    case info
    case warning
    case error
    case all
}

@objcMembers public final class EZLogFormatter: NSObject, DDLogFormatter {
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter
    }()
    
    public func format(message logMessage: DDLogMessage) -> String? {
        
        var flag: String!
        
        switch logMessage.flag {
        case .verbose: flag = "[v]"
        case .debug:   flag = "[d]"
        case .info:    flag = "[i]"
        case .warning: flag = "[w]"
        case .error:   flag = "[e]"
        default:       flag = "[?]"
        }
        
        let time = "[\(dateFormatter.string(from: logMessage.timestamp))]"
        let message = logMessage.message
        
        return "\(flag!)\(time): \(message)"
    }
}

@objcMembers public final class EZLogger: NSObject, DDLogger {
    
    public static func initialize(level: LogLevel = .all) {
        Logger.initialize(level: level)
    }
    
    public override init() {
        super.init()
        logFormatter = EZLogFormatter()
    }
    
    public var logFormatter: DDLogFormatter?
    
    public func log(message logMessage: DDLogMessage) {
        let message = logFormatter?.format(message: logMessage) ?? logMessage.message
        print(message)
    }
}

public struct Logger {
    
    public static func initialize(level: LogLevel = .all) {
        logLevel = level
        
        DDLog.add(EZLogger())
        
        let fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    public static var logLevel: LogLevel = .all {
        didSet {
            switch logLevel {
            case .off: dynamicLogLevel = .off
            case .verbose: dynamicLogLevel = .verbose
            case .debug: dynamicLogLevel = .debug
            case .info: dynamicLogLevel = .info
            case .warning: dynamicLogLevel = .warning
            case .error: dynamicLogLevel = .error
            case .all: dynamicLogLevel = .all
            }
        }
    }
    
    public static func verbose(_ items: Any..., separator: String = " ") {
        _log(level: .verbose, items: items, separator: separator)
    }
    
    public static func debug(_ items: Any..., separator: String = " ") {
        _log(level: .debug, items: items, separator: separator)
    }
    
    public static func info(_ items: Any..., separator: String = " ") {
        _log(level: .info, items: items, separator: separator)
    }
    
    public static func warning(_ items: Any..., separator: String = " ") {
        _log(level: .warning, items: items, separator: separator)
    }
    
    public static func error(_ items: Any..., separator: String = " ") {
        _log(level: .error, items: items, separator: separator)
    }
    
    private static func _log(level: LogLevel, items: [Any], separator: String = " ") {
        let message = items.map { "\($0)" }.joined(separator: separator)
        switch level {
        case .verbose: DDLogVerbose(message)
        case .debug: DDLogDebug(message)
        case .info: DDLogInfo(message)
        case .warning: DDLogWarn(message)
        case .error: DDLogError(message)
        default: break
        }
    }
}

#endif

//
//  Logger.swift
//  GihubRepo
//
//  Created by Quang on 26/11/2023.
//

import Foundation

public enum LogLevel {
    case debug
    case warning
    case notice
    case error
}

extension LogLevel {
    var symbol: String {
        switch self {
        case .debug:
            return "DEBUG ✅"
        case .warning:
            return "WARNING ⚠️"
        case .notice:
            return "NOTICE 📣"
        case .error:
            return "ERROR ❌"
        }
    }
}

public struct Logger {

    private init() {}

    private static let connector = " "
    private static let queue = DispatchQueue(label: "Common_Logger", qos: .background)

    static func log(level: LogLevel,
                    useFullLog: Bool = true,
                    file: StaticString = #file,
                    function: StaticString = #function,
                    line: Int = #line,
                    messages: [Any]) {
        queue.async {
            let date: String = Date().formattedISO8601

            let fullMessages = getFullMessage(from: messages)

            /// 2021-8-20 20:11:11 DEBUG ✅
            let headLine = "\(date) \(level.symbol)"

            let address = [getFileName("\(file)"), "\(function)", "line: \(line)"].joined(separator: connector)

            let logString = useFullLog

            ? [headLine, address, fullMessages].joined(separator: connector)

            : [headLine, fullMessages].joined(separator: connector)

            print(logString)
        }
    }

    static func getFullMessage(from objects: [Any]) -> String {
        var string: String = ""
        for element in objects.map({ "\($0)"}) {
            if string.isEmpty {
                string = element
            } else {
                string = string + " " + element
            }
        }

        return string
    }

    static func getFileName(_ url: String) -> String {
        return String(url.split(separator: "/").last ?? "")
    }

    public static func d(useFullLog: Bool = true,
                  file: StaticString = #file,
                  function: StaticString = #function,
                  line: Int = #line,
                  messages: Any...) {
        log(level: .debug,
            useFullLog: useFullLog,
            file: file,
            function: function,
            line: line,
            messages: messages)
    }

    public static func w(
        useFullLog: Bool = true,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        messages: Any...) {
            log(level: .warning,
                useFullLog: useFullLog,
                file: file,
                function: function,
                line: line,
                messages: messages)
        }

    public static func n(useSymbol: Bool = true,
                  useFullLog: Bool = true,
                  useShortDate: Bool = false,
                  file: StaticString = #file,
                  function: StaticString = #function,
                  line: Int = #line,
                  messages: Any...) {
        log(level: .notice,
            useFullLog: useFullLog,
            file: file,
            function: function,
            line: line,
            messages: messages)
    }

   public static func e(
        useFullLog: Bool = true,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        messages: Any...) {
            log(level: .error,
                useFullLog: useFullLog,
                file: file,
                function: function,
                line: line,
                messages: messages)
        }
}

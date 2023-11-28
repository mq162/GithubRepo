//
//  DateExtension.swift
//  
//
//  Created by Quang on 26/11/2023.
//

import Foundation

extension Date {

    /// Date Format type
    public enum DateFormatType: String {
        /// hour
        case hour = "HH"

        /// minute
        case minute = "mm"

        /// time
        case time = "HH:mm"

        /// Date
        case standardDate = "yyyy-MM-dd HH:mm:ss"

        var instance: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = rawValue
            dateFormatter.calendar = Calendar.current
            dateFormatter.locale = Calendar.current.locale
            dateFormatter.timeZone = Calendar.current.timeZone
            return dateFormatter
        }
    }

    public var formattedISO8601: String { return DateFormatType.standardDate.instance.string(from: self) }
}

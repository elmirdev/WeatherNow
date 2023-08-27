//
//  DateHelper.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 28.08.23.
//

import Foundation

class DateHelper {
    public static func getFormattedDate(dateString: String, dateFormat: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            
            // MARK: Hour
            let hour = calendar.component(.hour, from: date)
            
            // MARK: Week Day
            let weekFormatter = DateFormatter()
            weekFormatter.dateFormat = "EEE"
            let weekDay = weekFormatter.string(from: date)
            
            // MARK: Day
            let day = calendar.component(.day, from: date)
            
            // MARK: Month Name
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let monthName = monthFormatter.string(from: date)
            
            switch dateFormat {
            case .hour:
                return "\(hour):00"
            case .weekDayMonth:
                return "\(weekDay) \(day) \(monthName)"
            }
        } else {
            return "Loading..."
        }
    }
}

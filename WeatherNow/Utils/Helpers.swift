//
//  Helpers.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 02.09.23.
//

import Foundation

enum DateType {
    case hour
    case weekDayMonth
}

enum PeriodOfDay {
    case day
    case night
}

enum ValueType {
    case temperature
    case precipitation
    case uv
    case wind
    case humidity
    case pressure
    
    var unit: String {
        switch self {
        case .temperature:
            return "°"
        case .precipitation:
            return "%"
        case .uv:
            return ""
        case .wind:
            return " km/h"
        case .humidity:
            return "%"
        case .pressure:
            return " hPa"
        }
    }
    
    var imageText: String {
        switch self {
        case .temperature:
            return "temperature"
        case .precipitation:
            return "precipitation"
        case .uv:
            return "1000d"
        case .wind:
            return "wind"
        case .humidity:
            return "humidity"
        case .pressure:
            return "pressure"
        }
    }
    
    var title: String {
        switch self {
        case .temperature:
            return "Feels Like"
        case .precipitation:
            return "Precipitation"
        case .uv:
            return "UV Index"
        case .wind:
            return "Wind Speed"
        case .humidity:
            return "Humidity"
        case .pressure:
            return "Pressure"
        }
    }
}


class Helpers {
    static let shared = Helpers()
    
    func getDate(dateString: String, dateType: DateType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            
            // MARK: Week Day
            let weekFormatter = DateFormatter()
            weekFormatter.dateFormat = "EEE"
            let weekDay = weekFormatter.string(from: date)
            
            // MARK: Day
            let day = calendar.component(.day, from: date)
            
            //MARK: - Hour
            let hour = calendar.component(.hour, from: date)
            
            // MARK: Month Name
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let monthName = monthFormatter.string(from: date)
            
            switch dateType {
            case .hour:
                return "\(hour):00"
            case .weekDayMonth:
                return "\(weekDay) \(day) \(monthName)"
            }
        } else {
            return "Loading..."
        }
    }
    
    func getImageName(weather: WeatherEntity? = nil, hour: HourEntity? = nil) -> String {
        var code = 1000
        var periodOfDay: PeriodOfDay = .day
        if let weather {
            code = weather.currentWeather.condition.code
            periodOfDay = weather.currentWeather.condition.getPeriodOfDay()
        }
        if let hour {
            code = hour.condition.code
            periodOfDay = hour.condition.getPeriodOfDay()
        }
        switch code {
        case 1000:
            return periodOfDay == .day ? "1000d" : "1000n"
        case 1003:
            return periodOfDay == .day ? "1003d" : "1003n"
        case 1006, 1009, 1030:
            return periodOfDay == .day ? "1006d" : "1006n"
        case 1063, 1180, 1186, 1192, 1240, 1243, 1246:
            return periodOfDay == .day ? "1063d" : "1063n"
        case 1066, 1069, 1210, 1216, 1222, 1255, 1258, 1261, 1264:
            return periodOfDay == .day ? "1066d" : "1066n"
        case 1072, 1213, 1219, 1225, 1237:
            return periodOfDay == .day ? "1072d" : "1072n"
        case 1087, 1273:
            return periodOfDay == .day ? "1087d" : "1087n"
        case 1114, 1117:
            return periodOfDay == .day ? "1114d" : "1114n"
        case 1135:
            return periodOfDay == .day ? "1135d" : "1135n"
        case 1147:
            return periodOfDay == .day ? "1147d" : "1147n"
        case 1150, 1153, 1183, 1189, 1195:
            return periodOfDay == .day ? "1150d" : "1150n"
        case 1168, 1171, 1198, 1201, 1204, 1207:
            return periodOfDay == .day ? "1168d" : "1168n"
        case 1249, 1252:
            return periodOfDay == .day ? "1249d" : "1249n"
        case 1276:
            return periodOfDay == .day ? "1276d" : "1276n"
        case 1279:
            return periodOfDay == .day ? "1279d" : "1279n"
        case 1282:
            return periodOfDay == .day ? "1282d" : "1282n"
        default:
            return periodOfDay == .day ? "1006d" : "1006n"
        }
    }
}

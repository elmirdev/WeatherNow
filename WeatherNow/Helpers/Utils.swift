//
//  Utils.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 15.08.23.
//

import Foundation

enum PeriodOfDay {
    case day
    case night
}

enum ValueType {
    case temperature
    case precipitation
    case wind
    case humidity
    case pressure
    case uv
    
    var imageText: String {
        switch self {
        case .temperature:
            return "temperature"
        case .precipitation:
            return "precipitation"
        case .wind:
            return "wind"
        case .humidity:
            return "humidity"
        case .pressure:
            return "pressure"
        case .uv:
            return "1000d"
        }
    }
    
    var title: String {
        switch self {
        case .temperature:
            return "Feels Like"
        case .precipitation:
            return "Precipitation"
        case .wind:
            return "Wind Speed"
        case .humidity:
            return "Humidity"
        case .pressure:
            return "Pressure"
        case .uv:
            return "UV Index"
        }
    }
    
    var unit: String {
        switch self {
            
        case .temperature:
            return "°"
        case .precipitation:
            return "%"
        case .wind:
            return " km/h"
        case .pressure:
            return " hPa"
        case .humidity:
            return "%"
        case .uv:
            return ""
        }
    }
}

enum DateFormat {
    case hour
    case weekDayMonth
}

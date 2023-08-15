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

enum UnitOfValue {
    case temperature
    case percentage
    case speed
    case pressure
    case none
    
    var unit: String {
        switch self {
            
        case .temperature:
            return "°"
        case .percentage:
            return "%"
        case .speed:
            return " km/h"
        case .pressure:
            return " hPa"
        case .none:
            return ""
        }
    }
}

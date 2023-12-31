//
//  WeatherModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 05.06.23.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let location: Location
    let current: Current
    let forecast: ForecastModel
}

// MARK: - Current
struct Current: Codable {
    let tempC: CGFloat
    let tempF: CGFloat
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let pressureMB: CGFloat
    let pressureIn: CGFloat
    let precipMm, precipIn: CGFloat
    let humidity, cloud: Int
    let feelslikeC, feelslikeF: CGFloat
    let uv: CGFloat

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case uv
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
    let code: Int
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: CGFloat
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}


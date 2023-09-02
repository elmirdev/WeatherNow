//
//  ForecastModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 22.06.23.
//

import Foundation

// MARK: - Forecast
struct ForecastDTO: Codable {
    let forecastday: [ForecastdayDTO]
}

// MARK: - Forecastday
struct ForecastdayDTO: Codable {
    let date: String
    let day: DayDTO
    let astro: AstroDTO
    let hour: [HourDTO]

    enum CodingKeys: String, CodingKey {
        case date, day, astro, hour
    }
}

// MARK: - Astro
struct AstroDTO: Codable {
    let sunrise, sunset, moonrise, moonset: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
    }
}

// MARK: - Day
struct DayDTO: Codable {
    let condition: ConditionDTO

    enum CodingKeys: String, CodingKey {
        case condition
    }
}

// MARK: - Hour
struct HourDTO: Codable {
    let time: String
    let tempC, tempF: CGFloat
    let isDay: Int
    let condition: ConditionDTO
    let windMph, windKph: Double
    let precipMm, precipIn: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF: CGFloat

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
    }
}

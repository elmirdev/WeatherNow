//
//  ForecastModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 22.06.23.
//

import Foundation

// MARK: - Forecast
struct ForecastModel: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date, day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
    }
}

// MARK: - Day
struct Day: Codable {
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case condition
    }
}

// MARK: - Hour
struct Hour: Codable {
    let time: String
    let tempC, tempF: CGFloat
    let isDay: Int
    let condition: Condition
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

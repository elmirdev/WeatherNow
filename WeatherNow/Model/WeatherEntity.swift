//
//  WeatherEntity.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 02.09.23.
//

import Foundation

struct WeatherEntity {
    let location: LocationEntity
    let currentWeather: CurrentWeatherEntity
    let forecast: [ForecastDayEntity]
    
    init(location: LocationEntity, currentWeather: CurrentWeatherEntity, forecast: [ForecastDayEntity]) {
        self.location = location
        self.currentWeather = currentWeather
        self.forecast = forecast
    }
}

extension WeatherEntity {
    static let mock = WeatherEntity(location: .init(name: "", region: "", country: "", localtime: ""), currentWeather: .init(temp: 0, condition: .init(text: "", icon: "", code: 0), windSpeed: 0.0, pressure: 0.0, precipitation: 0.0, humidity: 0, feelsLike: 0.0, uv: 0.0), forecast: [.init(date: "", condition: .init(text: "", icon: "", code: 0), hour: [.init(time: "", condition: .init(text: "", icon: "", code: 0))])])
}

struct LocationEntity {
    let name, region, country: String
    let localtime: String
}

struct CurrentWeatherEntity {
    let temp: CGFloat
    let condition: ConditionEntity
    let windSpeed: Double
    let pressure: CGFloat
    let precipitation: CGFloat
    let humidity: Int
    let feelsLike: CGFloat
    let uv: CGFloat
}

struct ConditionEntity {
    let text: String
    let icon: String
    let code: Int
}

extension ConditionEntity {
    func getPeriodOfDay() -> PeriodOfDay {
        return icon.contains("day") ? .day : .night
    }
}

struct ForecastDayEntity {
    let date: String
    let condition: ConditionEntity
    let hour: [HourEntity]
}

struct HourEntity {
    let time: String
    let condition: ConditionEntity
}

// MARK: - Extensions
extension WeatherEntity {
    init(from data: WeatherDTO) {
        self.init(location: LocationEntity(from: data.location), currentWeather: CurrentWeatherEntity(from: data.current), forecast: data.forecast.forecastday.map({ForecastDayEntity(from: $0)}))
    }
}

extension LocationEntity {
    init(from data: LocationDTO) {
        self.init(name: data.name, region: data.region, country: data.country, localtime: data.localtime)
    }
}

extension CurrentWeatherEntity {
    init(from data: CurrentDTO) {
        self.init(temp: data.tempC, condition: ConditionEntity(from: data.condition), windSpeed: data.windKph, pressure: data.pressureMB, precipitation: data.precipIn, humidity: data.humidity, feelsLike: data.feelslikeC, uv: data.uv)
    }
}

extension ConditionEntity {
    init(from data: ConditionDTO) {
        self.init(text: data.text, icon: data.icon, code: data.code)
    }
}

extension ForecastDayEntity {
    init(from data: ForecastdayDTO) {
        self.init(date: data.date, condition: ConditionEntity(from: data.day.condition), hour: data.hour.map({HourEntity(from: $0)}))
    }
}

extension HourEntity {
    init(from data: HourDTO) {
        self.init(time: data.time, condition: ConditionEntity(from: data.condition))
    }
}

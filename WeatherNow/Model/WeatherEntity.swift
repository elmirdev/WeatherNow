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
    static let mock = WeatherEntity(location: .init(name: "", region: "", country: "", localtime: ""), currentWeather: .init(tempC: 0, condition: .init(text: "", icon: "", code: 0), windKph: 0.0, pressureMB: 0.0, precipIn: 0.0, humidity: 0, feelslikeC: 0.0, uv: 0.0), forecast: [.init(date: "", condition: .init(text: "", icon: "", code: 0), hour: [.init(time: "", tempC: 0.0, condition: .init(text: "", icon: "", code: 0))])])
}

struct LocationEntity {
    let name, region, country: String
    let localtime: String
}

struct CurrentWeatherEntity {
    let tempC: CGFloat
    let condition: ConditionEntity
    let windKph: Double
    let pressureMB: CGFloat
    let precipIn: CGFloat
    let humidity: Int
    let feelslikeC: CGFloat
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
    let tempC: CGFloat
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
        self.init(tempC: data.tempC, condition: ConditionEntity(from: data.condition), windKph: data.windKph, pressureMB: data.pressureMB, precipIn: data.precipIn, humidity: data.humidity, feelslikeC: data.feelslikeC, uv: data.uv)
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
        self.init(time: data.time, tempC: data.tempC, condition: ConditionEntity(from: data.condition))
    }
}

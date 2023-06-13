//
//  MainViewModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {

    @Published var weather = WeatherModel(location: Location(name: "-", region: "-", country: "-", lat: 0, lon: 0, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(lastUpdatedEpoch: 0, lastUpdated: "", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, visKM: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0))
    
    init() {
        getData()
    }
    
    func getData() {
        NetworkManager.shared.getWeather { weather in
                self.weather = weather
        }
    }
}

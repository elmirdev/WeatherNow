//
//  MainViewModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {

    @Published var weather: WeatherModel?
    
    init() {
        getData()
    }
    
    func getData() {
        NetworkManager.shared.getWeather { weather in
            DispatchQueue.main.async {
                self.weather = weather
            }
        }
    }
}

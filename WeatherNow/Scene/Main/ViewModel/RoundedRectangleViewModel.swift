//
//  RoundedRectangleViewModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 28.08.23.
//

import Foundation
import SwiftUI

class RoundedRectangleViewModel: ObservableObject {
    let weather: WeatherModel?
    
    @Published var colors: [Color] = [.blue, .gray.opacity(0.5), .gray.opacity(0.5)]
    @Published var selectedDay = 0

    init(weather: WeatherModel?) {
        self.weather = weather
    }
}

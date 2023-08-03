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
        
    func getData(completion: @escaping()->()) {
//        NetworkManager.shared.getWeather { weather in
//            DispatchQueue.main.async {
//                self.weather = weather
//                completion()
//            }
//        }
//        guard let jsonData = jsonString.data(using: .utf8) else { return }
        if let path = Bundle.main.path(forResource: "getWeatherResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                self.weather = weather
                completion()
            } catch {
                print("DEBUG: Error \(error)")
            }
        }
    }
    
    var imageName: String {
        guard let weather else { return "1003n" }
        switch weather.current.condition.code {
        case 1000:
            return "1000d"
        case 1003:
            return "1003d"
        case 1006, 1009, 1030:
            return "1006d"
        case 1063, 1180, 1186, 1192, 1240, 1243, 1246:
            return "1063d"
        case 1066, 1069, 1210, 1216, 1222, 1255, 1258, 1261, 1264:
            return "1066d"
        case 1072, 1213, 1219, 1225, 1237:
            return "1072d"
        case 1087, 1273:
            return "1087d"
        case 1114, 1117:
            return "1114d"
        case 1135:
            return "1135d"
        case 1147:
            return "1147d"
        case 1150, 1153, 1183, 1189, 1195:
            return "1150d"
        case 1168, 1171, 1198, 1201, 1204, 1207:
            return "1168d"
        case 1249, 1252:
            return "1249d"
        case 1276:
            return "1276d"
        case 1279:
            return "1279d"
        case 1282:
            return "1282d"
        default:
            return "1000n"
        }
    }
}

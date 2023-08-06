//
//  MainViewModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI

enum PeriodOfDay {
    case day
    case night
}

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
    
    func getImageName(code: Int, periodOfDay: PeriodOfDay) -> String {
        switch code {
        case 1000:
            return periodOfDay == .day ? "1000d" : "1000n"
        case 1003:
            return periodOfDay == .day ? "1003d" : "1003n"
        case 1006, 1009, 1030:
            return periodOfDay == .day ? "1006d" : "1006n"
        case 1063, 1180, 1186, 1192, 1240, 1243, 1246:
            return periodOfDay == .day ? "1063d" : "1063n"
        case 1066, 1069, 1210, 1216, 1222, 1255, 1258, 1261, 1264:
            return periodOfDay == .day ? "1066d" : "1066n"
        case 1072, 1213, 1219, 1225, 1237:
            return periodOfDay == .day ? "1072d" : "1072n"
        case 1087, 1273:
            return periodOfDay == .day ? "1087d" : "1087n"
        case 1114, 1117:
            return periodOfDay == .day ? "1114d" : "1114n"
        case 1135:
            return periodOfDay == .day ? "1135d" : "1135n"
        case 1147:
            return periodOfDay == .day ? "1147d" : "1147n"
        case 1150, 1153, 1183, 1189, 1195:
            return periodOfDay == .day ? "1150d" : "1150n"
        case 1168, 1171, 1198, 1201, 1204, 1207:
            return periodOfDay == .day ? "1168d" : "1168n"
        case 1249, 1252:
            return periodOfDay == .day ? "1249d" : "1249n"
        case 1276:
            return periodOfDay == .day ? "1276d" : "1276n"
        case 1279:
            return periodOfDay == .day ? "1279d" : "1279n"
        case 1282:
            return periodOfDay == .day ? "1282d" : "1282n"
        default:
            return periodOfDay == .day ? "1000d" : "1000n"
        }
    }
}

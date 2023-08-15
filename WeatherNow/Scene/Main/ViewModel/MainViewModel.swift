//
//  MainViewModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI
import CoreLocation

class MainViewModel: NSObject, ObservableObject {

    @Published var weather: WeatherModel?
    private let locationManager = CLLocationManager()
        
        override init() {
            super.init()
            fetchUserLocation()
        }
    
    private func getData(lat: CGFloat, long: CGFloat) {
        NetworkManager.shared.getWeather(lat: lat, long: long) { weather in
            DispatchQueue.main.async {
                self.weather = weather
            }
        }
    }
    
    private func getDataFromLocal() {
        if let path = Bundle.main.path(forResource: "getWeatherResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                self.weather = weather
            } catch {
                print("DEBUG: Error \(error)")
            }
        }
    }
    
    var periodOfHour: PeriodOfDay {
        guard let icon = weather?.current.condition.icon else { return .day }
        if icon.contains("day") {
            return .day
        } else if icon.contains("night") {
            return .night
        }
        return .day
    }
    
    var bgColor: Color {
        guard let code = weather?.current.condition.code else { return .black }
        let colorName = getImageName(code: code, periodOfDay: periodOfHour)
        return Color(colorName)
    }
    
    var cityName: String {
        guard let location = weather?.location else { return "Loading..." }
        if location.country == "Azerbaijan" {
            return location.region // MARK: Hierarchy is different in our Azerbaijan
        } else {
            return location.name
        }
    }
    
    var imageName: String {
        guard let code = weather?.current.condition.code else { return "1006d" }
        let imageName = getImageName(code: code, periodOfDay: periodOfHour)
        return imageName
    }
    
    var conditionText: String {
        return weather?.current.condition.text ?? "Loading..."
    }
    
    var localtimeText: String {
        return weather?.location.localtime ?? "Loading..."
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
            return periodOfDay == .day ? "1006d" : "1006n"
        }
    }
    
    private func fetchUserLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}

extension MainViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        getData(lat: latitude, long: longitude)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}

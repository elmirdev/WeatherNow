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

    @Published var weather: WeatherEntity?
    @Published var bgColor = Color.black
    @Published var tempC: CGFloat = 0
    @Published var imageOffset = CGSize(width: 0, height: UIScreen.main.bounds.height)
    @Published var isExpanded = false

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
    
//    private func getDataFromLocal() {
//        if let path = Bundle.main.path(forResource: "getWeatherResponse", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let weather = try JSONDecoder().decode(WeatherDTO.self, from: data)
//                self.weather = weather
//            } catch {
//                print("DEBUG: Error \(error)")
//            }
//        }
//    }
        
    var bgColorFromData: Color {
        guard let weather else { return .black }
        let colorName = Helpers.shared.getImageName(weather: weather)
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
        guard let weather = weather else { return "1006d" }
        let imageName = Helpers.shared.getImageName(weather: weather)
        return imageName
    }
    
    var conditionText: String {
        return weather?.current.condition.text ?? "Loading..."
    }
    
    var localtimeText: String {
        return weather?.location.localtime ?? "Loading..."
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

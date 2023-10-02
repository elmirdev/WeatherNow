//
//  HourlyTemperatureViewModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 28.08.23.
//

import Foundation

class HourlyTemperatureViewModel: ObservableObject {
    let hour: Hour
    
    init(hour: Hour) {
        self.hour = hour
    }
    
    var tempC: CGFloat {
        return hour.tempC
    }
    
    var hourText: String {
        getHour(dateString: hour.time)
    }
    
    var imageName: String {
        WeatherHelper.getImageName(code: hour.condition.code, periodOfDay: periodOfDay)
    }
        
    var periodOfDay: PeriodOfDay {
        WeatherHelper.getPeriodOfDay(imageText: hour.condition.icon)
    }
    
    func getHour(dateString: String) -> String {
        DateHelper.getFormattedDate(dateString: hour.time, dateFormat: .hour)
    }
}

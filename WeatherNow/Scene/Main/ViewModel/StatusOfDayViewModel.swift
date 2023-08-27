//
//  StatusOfDayViewModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 28.08.23.
//

import Foundation

class StatusOfDayViewModel {
    let status: String
    let date: String
    
    init(status: String, date: String) {
        self.status = status
        self.date = date
    }
    
    var hour: String  {
        return getHour(dateString: date)
    }
    
    func getHour(dateString: String) -> String {
        DateHelper.getFormattedDate(dateString: dateString, dateFormat: .hour)
    }
}

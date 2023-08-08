//
//  StatusOfDayAndDateView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct StatusOfDayAndDateView: View {
    let status: String
    let date: String
    @Binding var isZoomed: Bool
    
    var body: some View {
        VStack(alignment: isZoomed ? .leading : .center, spacing: 8) {
            Text(status)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text(getHour(dateString: date))
                .foregroundColor(.white)
        }
    }
    
    func getHour(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            
            // MARK: Week Day
            let weekFormatter = DateFormatter()
            weekFormatter.dateFormat = "EEE"
            let weekDay = weekFormatter.string(from: date)
            
            // MARK: Day
            let day = calendar.component(.day, from: date)
            
            // MARK: Month Name
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let monthName = monthFormatter.string(from: date)
            return "\(weekDay) \(day) \(monthName)"
        } else {
            return "Loading.."
        }
    }
}

struct StatusOfDayAndDateView_Previews: PreviewProvider {
    static var previews: some View {
        StatusOfDayAndDateView(status: "It's raining", date: "June", isZoomed: .constant(false))
    }
}

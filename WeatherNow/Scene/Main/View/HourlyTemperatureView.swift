//
//  HourlyDegreeIcon.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI

struct HourlyTemperatureView: View {
    let hour: Hour
    let mainViewModel = MainViewModel()
    
    @State private var animatableValue: CGFloat = 0

    var body: some View {
        VStack(spacing: 8) {
            Text(getHour(dateString: hour.time))
                .font(.system(size: 14))
                .foregroundColor(.gray)
            if let periodOfHour {
                Image(mainViewModel.getImageName(code: hour.condition.code, periodOfDay: periodOfHour))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .padding(2)
            }
            TextAnimatableValue(value: animatableValue, unitOfValue: .temperature)
                .font(.system(size: 16, weight: .semibold))
        }.onAppear {
            withAnimation(.easeInOut(duration: 2)) {
                self.animatableValue = hour.tempC
            }
        }
        .onChange(of: hour.tempC) { newValue in
            withAnimation(.easeInOut(duration: 1)) {
                self.animatableValue = newValue
            }
        }
    }
    
    func getHour(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            return "\(hour):00"
        } else {
            return "-"
        }
    }
    
    var periodOfHour: PeriodOfDay? {
        if hour.condition.icon.contains("day") {
            return .day
        } else if hour.condition.icon.contains("night") {
            return .night
        }
        return nil
    }
}

struct HourlyDegreeCell_Previews: PreviewProvider {
    static var previews: some View {
        HourlyTemperatureView(hour: Hour(time: "2023-08-07 00:00", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "day", code: 1000), windMph: 0, windKph: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0))
    }
}

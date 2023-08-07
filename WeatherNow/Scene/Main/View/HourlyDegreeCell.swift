//
//  HourlyDegreeIcon.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI

struct HourlyDegreeCell: View {
    let hour: Hour
    let mainViewModel = MainViewModel()
    
    @State private var animatableValue: CGFloat = 0

    var body: some View {
        VStack(spacing: 16) {
            Text(getHour(dateString: hour.time))
                .font(.callout)
                .foregroundColor(.gray)
            if let periodOfHour {
                Image(mainViewModel.getImageName(code: hour.condition.code, periodOfDay: periodOfHour))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .padding(6)
                    .background {
                        Circle()
                            .fill(.quaternary.opacity(0.2))
                    }
            }
            TextAnimatableValue(value: animatableValue, unit: "°")
                .font(.callout)
                .fontWeight(.semibold)
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
        HourlyDegreeCell(hour: Hour(timeEpoch: 1687464000, time: "2023-06-23 00:00", tempC: 23.4, tempF: 23.4, isDay: 0, condition: Condition(text: "Partly cloudy", icon: "day", code: 1003), windMph: 14.8, windKph: 14.8, windDegree: 15, windDir: "NNE", pressureMB: 4.4, pressureIn: 4.4, precipMm: 4.4, precipIn: 4.4, humidity: 12, cloud: 9, feelslikeC: 3.8, feelslikeF: 3.9, windchillC: 3.98, windchillF: 1.9, heatindexC: 1.9, heatindexF: 2.9, dewpointC: 2.9, dewpointF: 2.9, willItRain: 8, chanceOfRain: 8, willItSnow: 8, chanceOfSnow: 8, visKM: 8.8, visMiles: 8.8, gustMph: 8.8, gustKph: 88.8, uv: 8.8))
    }
}

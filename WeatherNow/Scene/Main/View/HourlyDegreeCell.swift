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
    @State private var animatableValue: CGFloat = 0

    var body: some View {
        VStack(spacing: 16) {
            Text(getHour(dateString: hour.time))
                .font(.callout)
                .foregroundColor(.gray)
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(8)
                .background {
                    Circle()
                        .fill(.quaternary.opacity(0.3))
                }
            TextAnimatableValue(value: animatableValue)
                .font(.callout)
                .fontWeight(.semibold)
        }.onAppear {
            withAnimation(.easeInOut(duration: 2)) {
                self.animatableValue = hour.tempC
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
    
    var imageName: String {
        switch hour.condition.code {
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
        }}
}

struct HourlyDegreeCell_Previews: PreviewProvider {
    static var previews: some View {
        HourlyDegreeCell(hour: Hour(timeEpoch: 1687464000, time: "2023-06-23 00:00", tempC: 23.4, tempF: 23.4, isDay: 0, condition: Condition(text: "Partly cloudy", icon: "", code: 1003), windMph: 14.8, windKph: 14.8, windDegree: 15, windDir: "NNE", pressureMB: 4.4, pressureIn: 4.4, precipMm: 4.4, precipIn: 4.4, humidity: 12, cloud: 9, feelslikeC: 3.8, feelslikeF: 3.9, windchillC: 3.98, windchillF: 1.9, heatindexC: 1.9, heatindexF: 2.9, dewpointC: 2.9, dewpointF: 2.9, willItRain: 8, chanceOfRain: 8, willItSnow: 8, chanceOfSnow: 8, visKM: 8.8, visMiles: 8.8, gustMph: 8.8, gustKph: 88.8, uv: 8.8))
    }
}

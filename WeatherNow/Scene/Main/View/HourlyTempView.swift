//
//  HourlyDegreeIcon.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI

struct HourlyTempView: View {
    let hour: HourDTO
    let mainViewModel = MainViewModel()
    
    @State private var animatableValue: CGFloat = 0

    var body: some View {
        VStack(spacing: 8) {
            Text(Helpers.shared.getDate(dateString: hour.time, dateType: .hour))
                .font(.system(size: 14))
                .foregroundColor(.gray)
                Image(Helpers.shared.getImageName(hour: hour))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .padding(2)
            TextAnimatableValue(value: animatableValue, unit: "°")
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
}

struct HourlyDegreeCell_Previews: PreviewProvider {
    static var previews: some View {
        HourlyTempView(hour: HourDTO(time: "2023-08-07 00:00", tempC: 0, tempF: 0, isDay: 0, condition: ConditionDTO(text: "", icon: "day", code: 1000), windMph: 0, windKph: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0))
    }
}

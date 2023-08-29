//
//  HourlyDegreeIcon.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI

struct HourlyTemperatureView: View {
    @ObservedObject var viewModel: HourlyTemperatureViewModel
    @State private var animatableValue: CGFloat = 0

    var body: some View {
        VStack(spacing: 8) {
            Text(viewModel.hourText)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Image(viewModel.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .padding(2)
            TextAnimatableValue(value: animatableValue, valueType: .temperature)
                .font(.system(size: 16, weight: .semibold))
        }.onAppear {
            withAnimation(.easeInOut(duration: 2)) {
                animatableValue = viewModel.tempC
            }
        }
    }
}

struct HourlyDegreeCell_Previews: PreviewProvider {
    static var previews: some View {
        HourlyTemperatureView(viewModel: .init(hour: Hour(time: "2023-08-07 00:00", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "day", code: 1000), windMph: 0, windKph: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0)))
    }
}

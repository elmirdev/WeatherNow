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
            Image("sun")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .background {
                    Circle()
                        .fill(.quaternary.opacity(0.5))
                        .frame(width:32, height: 32)
                }
            TextAnimatableValue(value: animatableValue)
                .font(.callout)
                .fontWeight(.bold)
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
}

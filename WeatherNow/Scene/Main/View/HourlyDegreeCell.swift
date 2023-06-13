//
//  HourlyDegreeIcon.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import Foundation
import SwiftUI

struct HourlyDegreeCell: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("10 AM")
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
            Text("24°")
                .font(.callout)
                .fontWeight(.bold)
        }
    }
}

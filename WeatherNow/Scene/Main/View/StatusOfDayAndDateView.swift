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
    var body: some View {
        VStack(spacing: 8) {
            Text(status)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text(date)
                .foregroundColor(.white)
        }
    }
}

struct StatusOfDayAndDateView_Previews: PreviewProvider {
    static var previews: some View {
        StatusOfDayAndDateView(status: "It's raining", date: "June")
    }
}

//
//  StatusOfDayAndDateView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct StatusOfDayView: View {
    
    let viewModel: StatusOfDayViewModel
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: isExpanded ? .leading : .center, spacing: 8) {
            Text(viewModel.status)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text(viewModel.hour)
                .foregroundColor(.white)
        }
    }
}

struct StatusOfDayAndDateView_Previews: PreviewProvider {
    static var previews: some View {
        StatusOfDayView(viewModel: .init(status: "Cloudy", date: "2023-08-07 18:30"), isExpanded: .constant(false))
    }
}

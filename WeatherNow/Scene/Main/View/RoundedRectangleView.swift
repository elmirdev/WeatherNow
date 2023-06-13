//
//  RoundedRectangleView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct RoundedRectangleView: View {
    
    let weather: WeatherModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Weather information")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding([.horizontal, .top])
            HStack {
                VStack(alignment: .leading, spacing: 22) {
                    SmallIconWithTextCell(imageText: "temperature", title: "Feels Like", value: weather.current.feelslikeC)
                    SmallIconWithTextCell(imageText: "precipitation", title: "Precipitation", value: weather.current.precipIn)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 22) {
                    SmallIconWithTextCell(imageText: "wind", title: "Wind Speed", value: weather.current.windKph)
                    SmallIconWithTextCell(imageText: "humidity", title: "Humidity", value: CGFloat(weather.current.humidity))
                }
            }
            .padding(.horizontal, 28)
            .padding(.vertical)
            Divider()
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 32) {
                    HourlyDegreeCell()
                    HourlyDegreeCell()
                    HourlyDegreeCell()
                    HourlyDegreeCell()
                    HourlyDegreeCell()
                    HourlyDegreeCell()
                }
                .padding(.vertical)
                .padding(.horizontal, 28)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }.padding()
    }
}

struct RoundedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleView(weather: WeatherModel(location: Location(name: "-", region: "-", country: "-", lat: 0, lon: 0, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(lastUpdatedEpoch: 0, lastUpdated: "", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, visKM: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0)))
    }
}

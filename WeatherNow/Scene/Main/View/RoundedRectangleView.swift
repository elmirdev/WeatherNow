//
//  RoundedRectangleView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct RoundedRectangleView: View {
    
    let weather: WeatherModel?
    @Binding var isZoomed: Bool
    
    var body: some View {
        if let weather {
            VStack {
                HStack {
                    Text("Weather information")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.horizontal, .top])
                HStack {
                    VStack(alignment: .leading, spacing: 22) {
                        SmallIconWithTextCell(imageText: "temperature", title: "Feels Like", value: weather.current.feelslikeC, isZoomed: $isZoomed)
                        SmallIconWithTextCell(imageText: "precipitation", title: "Precipitation", value: weather.current.precipIn, isZoomed: $isZoomed)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 22) {
                        SmallIconWithTextCell(imageText: "wind", title: "Wind Speed", value: weather.current.windKph, isZoomed: $isZoomed)
                        SmallIconWithTextCell(imageText: "humidity", title: "Humidity", value: CGFloat(weather.current.humidity), isZoomed: $isZoomed)
                    }
                }
                .padding(.horizontal, 28)
                .padding(.vertical)
                Divider()
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 32) {
                        if let hours = weather.forecast.forecastday.first?.hour {
                            ForEach(hours.indices, id: \.self) { index in
                                HourlyDegreeCell(hour: hours[index])
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 28)
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.white)
            }.padding()
        } else {
            VStack {
                HStack {
                    Text("Weather information")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.horizontal, .top])
                HStack {
                    VStack(alignment: .leading, spacing: 22) {
                        SmallIconWithTextCell(imageText: "temperature", title: "Feels Like", value: 0, isZoomed: $isZoomed)
                        SmallIconWithTextCell(imageText: "precipitation", title: "Precipitation", value: 0, isZoomed: $isZoomed)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 22) {
                        SmallIconWithTextCell(imageText: "wind", title: "Wind Speed", value: 0, isZoomed: $isZoomed)
                        SmallIconWithTextCell(imageText: "humidity", title: "Humidity", value: 0, isZoomed: $isZoomed)
                    }
                }
                .padding(.horizontal, 28)
                .padding(.vertical)
                Divider()
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 32) {
                        ForEach(0..<11) { index in
                            HourlyDegreeCell(hour: Hour(timeEpoch: 0, time: "", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, windchillC: 0, windchillF: 0, heatindexC: 0, heatindexF: 0, dewpointC: 0, dewpointF: 0, willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0, visKM: 0, visMiles: 0, gustMph: 0, gustKph: 0, uv: 0))
                        }
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
}

struct RoundedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleView(weather: WeatherModel(location: Location(name: "-", region: "-", country: "-", lat: 0, lon: 0, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(lastUpdatedEpoch: 0, lastUpdated: "", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, visKM: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0), forecast: ForecastModel(forecastday: [Forecastday(date: "", dateEpoch: 1, day: Day(maxtempC: 1, maxtempF: 2, mintempC: 2, mintempF: 2, avgtempC: 1, avgtempF: 1, maxwindMph: 1, maxwindKph: 1, totalprecipMm: 1, totalprecipIn: 1, totalsnowCM: 1, avgvisKM: 1, avgvisMiles: 1, avghumidity: 1, dailyWillItRain: 1, dailyChanceOfRain: 1, dailyWillItSnow: 1, dailyChanceOfSnow: 1, condition: Condition(text: "", icon: "", code: 1), uv: 1), astro: Astro(sunrise: "", sunset: "", moonrise: "", moonset: "", moonPhase: "", moonIllumination: "", isMoonUp: 1, isSunUp: 1), hour: [Hour(timeEpoch: 1, time: "", tempC: 1, tempF: 1, isDay: 1, condition: Condition(text: "", icon: "", code: 2), windMph: 1, windKph: 1, windDegree: 1, windDir: "", pressureMB: 1, pressureIn: 1, precipMm: 1, precipIn: 1, humidity: 1, cloud: 1, feelslikeC: 1, feelslikeF: 1, windchillC: 1, windchillF: 1, heatindexC: 1, heatindexF: 1, dewpointC: 1, dewpointF: 1, willItRain: 1, chanceOfRain: 1, willItSnow: 1, chanceOfSnow: 1, visKM: 1, visMiles: 1, gustMph: 1, gustKph: 1, uv: 1)])])), isZoomed: .constant(false))
    }
}

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
    
    @State var days = ["Today"]
    @State var colors: [Color] = [.blue, .gray.opacity(0.5), .gray.opacity(0.5)]
    @State private var selectedDay = 0
    
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
                        if let weather {
                            SmallIconWithTextCell(imageText: "temperature", title: "Feels Like", value: weather.current.feelslikeC, unit: "°", isZoomed: $isZoomed)
                            SmallIconWithTextCell(imageText: "precipitation", title: "Precipitation", value: weather.current.precipIn, unit: "%", isZoomed: $isZoomed)
                        } else {
                            SmallIconWithTextCell(imageText: "temperature", title: "Feels Like", value: 0, unit: "°", isZoomed: $isZoomed)
                            SmallIconWithTextCell(imageText: "precipitation", title: "Precipitation", value: 0, unit: "%", isZoomed: $isZoomed)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 22) {
                        if let weather {
                            SmallIconWithTextCell(imageText: "wind", title: "Wind Speed", value: weather.current.windKph, unit: " km/h", isZoomed: $isZoomed)
                            SmallIconWithTextCell(imageText: "humidity", title: "Humidity", value: CGFloat(weather.current.humidity), unit: "%", isZoomed: $isZoomed)
                        } else {
                            SmallIconWithTextCell(imageText: "wind", title: "Wind Speed", value: 0, unit: " km/h", isZoomed: $isZoomed)
                            SmallIconWithTextCell(imageText: "humidity", title: "Humidity", value: 0, unit: "%", isZoomed: $isZoomed)
                        }
                    }
                }
                .padding(.horizontal, 28)
                .padding(.vertical)
                Divider()
                    .padding(.horizontal)
                
                HStack {
                    ForEach(days.indices, id: \.self) { index in
                        Text(index == 0 ? "Today" : "\(days[index]) Aug")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.vertical, 3)
                            .padding(.horizontal, 6)
                            .background {
                                Capsule()
                                    .fill(colors[index])
                            }.onTapGesture {
                                withAnimation(.spring()) {
                                    for colorIndex in 0..<colors.count {
                                        colors[colorIndex] = .gray.opacity(0.5)
                                    }
                                    colors[index] = .blue
                                    selectedDay = index
                                }
                            }
                    }
                }
                .frame(height: isZoomed ? .none : 0)
                .opacity(isZoomed ? 1 : 0)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    if let hours = weather?.forecast.forecastday[selectedDay].hour {
                        HStack(spacing: 32) {
                            ForEach(hours.indices, id: \.self) { index in
                                HourlyDegreeCell(hour: hours[index])
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 28)
                        .onAppear {
                            if let weather {
                                var forecastDays = [String]()
                                weather.forecast.forecastday.forEach { forecastDay in
                                    let day = getDay(dateString: forecastDay.date)
                                    forecastDays.append(day)
                                }
                                self.days = forecastDays
                            }
                        }
                    }
                }
            }.background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.white)
            }.padding()
    }
    func getDay(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            return "\(day)"
        } else {
            return "-"
        }
    }
}

struct RoundedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleView(weather: WeatherModel(location: Location(name: "-", region: "-", country: "-", lat: 0, lon: 0, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(lastUpdatedEpoch: 0, lastUpdated: "", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, visKM: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0), forecast: ForecastModel(forecastday: [Forecastday(date: "", dateEpoch: 1, day: Day(maxtempC: 1, maxtempF: 2, mintempC: 2, mintempF: 2, avgtempC: 1, avgtempF: 1, maxwindMph: 1, maxwindKph: 1, totalprecipMm: 1, totalprecipIn: 1, totalsnowCM: 1, avgvisKM: 1, avgvisMiles: 1, avghumidity: 1, dailyWillItRain: 1, dailyChanceOfRain: 1, dailyWillItSnow: 1, dailyChanceOfSnow: 1, condition: Condition(text: "", icon: "", code: 1), uv: 1), astro: Astro(sunrise: "", sunset: "", moonrise: "", moonset: "", moonPhase: "", moonIllumination: "", isMoonUp: 1, isSunUp: 1), hour: [Hour(timeEpoch: 1, time: "", tempC: 1, tempF: 1, isDay: 1, condition: Condition(text: "", icon: "", code: 2), windMph: 1, windKph: 1, windDegree: 1, windDir: "", pressureMB: 1, pressureIn: 1, precipMm: 1, precipIn: 1, humidity: 1, cloud: 1, feelslikeC: 1, feelslikeF: 1, windchillC: 1, windchillF: 1, heatindexC: 1, heatindexF: 1, dewpointC: 1, dewpointF: 1, willItRain: 1, chanceOfRain: 1, willItSnow: 1, chanceOfSnow: 1, visKM: 1, visMiles: 1, gustMph: 1, gustKph: 1, uv: 1)])])), isZoomed: .constant(true))
    }
}

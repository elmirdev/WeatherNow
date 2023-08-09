//
//  RoundedRectangleView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct RoundedRectangleView: View {
    
    let weather: WeatherModel?
    @Binding var isExpanded: Bool
    
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
                VStack(alignment: .leading, spacing: 12) {
                    if let weather {
                        SmallIconWithTextCell(imageText: "temperature", title: "Feels Like", value: weather.current.feelslikeC, unit: "°", isExpanded: $isExpanded)
                        SmallIconWithTextCell(imageText: "precipitation", title: "Precipitation", value: weather.current.precipIn, unit: "%", isExpanded: $isExpanded)
                        SmallIconWithTextCell(imageText: "1000d", title: "UV Index", value: weather.current.uv, unit: "", isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    } else {
                        SmallIconWithTextCell(imageText: "temperature", title: "Feels Like", value: 0, unit: "°", isExpanded: $isExpanded)
                        SmallIconWithTextCell(imageText: "precipitation", title: "Precipitation", value: 0, unit: "%", isExpanded: $isExpanded)
                        SmallIconWithTextCell(imageText: "1000d", title: "UV Index", value: 0, unit: "", isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    }
                }
                Spacer(minLength: 12)
                VStack(alignment: .leading, spacing: 12) {
                    if let weather {
                        SmallIconWithTextCell(imageText: "wind", title: "Wind Speed", value: weather.current.windKph, unit: " km/h", isExpanded: $isExpanded)
                        SmallIconWithTextCell(imageText: "humidity", title: "Humidity", value: CGFloat(weather.current.humidity), unit: "%", isExpanded: $isExpanded)
                        SmallIconWithTextCell(imageText: "pressure", title: "Pressure", value: weather.current.pressureMB, unit: " hPa", isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    } else {
                        SmallIconWithTextCell(imageText: "wind", title: "Wind Speed", value: 0, unit: " km/h", isExpanded: $isExpanded)
                        SmallIconWithTextCell(imageText: "humidity", title: "Humidity", value: 0, unit: "%", isExpanded: $isExpanded)
                        SmallIconWithTextCell(imageText: "pressure", title: "Pressure", value: 0, unit: " hPa", isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    }
                }
            }
            .padding(.horizontal)
            Divider()
                .padding(.horizontal)
            
            if let days = weather?.forecast.forecastday {
                HStack {
                    ForEach(days.indices, id: \.self) { index in
                        let day = getDayAndMonth(dateString: days[index].date).0
                        let monthName = getDayAndMonth(dateString:days[index].date).1
                        
                        Text(index == 0 ? "Today" : "\(day) \(monthName)")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
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
                .frame(height: isExpanded ? .none : .zero)
                .opacity(isExpanded ? 1 : 0)
            } else {
                Text("To not show junk")
                    .frame(height: .zero)
                    .opacity(0)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                if let hours = weather?.forecast.forecastday[selectedDay].hour {
                    HStack(spacing: 32) {
                        ForEach(hours.indices, id: \.self) { index in
                            HourlyDegreeCell(hour: hours[index])
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 28)
                } else {
                    HourlyDegreeCell(hour: Hour(time: "2023-08-07 00:00", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "day", code: 1000), windMph: 0, windKph: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0))
                        .padding(.vertical)
                        .padding(.horizontal, 28)
                }
            }
        }.background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.white)
        }.padding()
    }
    func getDayAndMonth(dateString: String) -> (String,String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            
            // MARK: Day
            let day = calendar.component(.day, from: date)
            
            // MARK: Month
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let monthName = monthFormatter.string(from: date)
            return ("\(day)","\(monthName)")
        } else {
            return ("-","-")
        }
    }
}

struct RoundedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleView(weather: WeatherModel(location: Location(name: "-", region: "-", country: "-", lat: 0, lon: 0, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(lastUpdatedEpoch: 0, lastUpdated: "", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMph: 0, windKph: 0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0, visKM: 0, visMiles: 0, uv: 0, gustMph: 0, gustKph: 0), forecast: ForecastModel(forecastday: [Forecastday(date: "", dateEpoch: 1, day: Day(maxtempC: 1, maxtempF: 2, mintempC: 2, mintempF: 2, avgtempC: 1, avgtempF: 1, maxwindMph: 1, maxwindKph: 1, totalprecipMm: 1, totalprecipIn: 1, totalsnowCM: 1, avgvisKM: 1, avgvisMiles: 1, avghumidity: 1, dailyWillItRain: 1, dailyChanceOfRain: 1, dailyWillItSnow: 1, dailyChanceOfSnow: 1, condition: Condition(text: "", icon: "", code: 1), uv: 1), astro: Astro(sunrise: "", sunset: "", moonrise: "", moonset: "", moonPhase: "", moonIllumination: "", isMoonUp: 1, isSunUp: 1), hour: [Hour(time: "2023-08-07 00:00", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "1000d", code: 1000), windMph: 0, windKph: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0)])])), isExpanded: .constant(true))
    }
}

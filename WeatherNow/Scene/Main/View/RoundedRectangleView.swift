//
//  RoundedRectangleView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct RoundedRectangleView: View {
    
    let weather: WeatherDTO?
    @Binding var isExpanded: Bool
    
    @State var colors: [Color] = [.blue, .gray.opacity(0.5), .gray.opacity(0.5)]
    @State private var selectedDay = 0
    
    var handleButton: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Weather information")
                    .fontWeight(.bold)
                Spacer()
                Button {
                    handleButton()
                } label: {
                    Image(systemName: "chevron.up.circle.fill")
                        .foregroundColor(.gray.opacity(0.5))
                        .font(.system(size: 28))
                        .rotationEffect(.degrees(isExpanded ? -180 : 0))
                }

            }
            .padding([.horizontal, .top])
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    if let weather {
                        SmallIconWithTextCell(value: weather.current.feelslikeC, valueType: .temperature, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: weather.current.precipIn, valueType: .precipitation, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: weather.current.uv, valueType: .uv, isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    } else {
                        SmallIconWithTextCell(value: 0, valueType: .temperature, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: 0, valueType: .precipitation, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: 0, valueType: .uv, isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    }
                }
                Spacer(minLength: 12)
                VStack(alignment: .leading, spacing: 12) {
                    if let weather {
                        SmallIconWithTextCell(value: weather.current.windKph, valueType: .wind, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: CGFloat(weather.current.humidity), valueType: .humidity, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: weather.current.pressureMB, valueType: .pressure, isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    } else {
                        SmallIconWithTextCell(value: 0, valueType: .wind, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: 0, valueType: .humidity, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: 0, valueType: .pressure, isExpanded: $isExpanded)
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
                            HourlyTempView(hour: hours[index])
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 28)
                } else {
                    HourlyTempView(hour: HourDTO(time: "2023-08-07 00:00", tempC: 0, tempF: 0, isDay: 0, condition: ConditionDTO(text: "", icon: "night", code: 1000), windMph: 0, windKph: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0))
                        .padding(.vertical, 8)
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
        RoundedRectangleView(weather: WeatherDTO(location: LocationDTO(name: "Baku", region: "Baku", country: "Azerbaijan", lat: 40, lon: 39, tzID: "", localtimeEpoch: 0, localtime: ""), current: CurrentDTO(tempC: 24, tempF: 23, isDay: 0, condition: ConditionDTO(text: "Sunny", icon: "day", code: 1000), windMph: 19, windKph: 19, pressureMB: 19, pressureIn: 19, precipMm: 19, precipIn: 19, humidity: 12, cloud: 1, feelslikeC: 24, feelslikeF: 45, uv: 1), forecast: ForecastDTO(forecastday: [ForecastdayDTO(date: "2023-08-07 00:00", day: DayDTO(condition: ConditionDTO(text: "Sunny", icon: "day", code: 1000)), astro: AstroDTO(sunrise: "", sunset: "", moonrise: "", moonset: ""), hour: [HourDTO(time: "", tempC: 24, tempF: 45, isDay: 0, condition: ConditionDTO(text: "", icon: "day", code: 1000), windMph: 12, windKph: 12, precipMm: 12, precipIn: 12, humidity: 12, cloud: 12, feelslikeC: 11, feelslikeF: 12)])])), isExpanded: .constant(true), handleButton: MainView().toggleIsExpanded)
    }
}

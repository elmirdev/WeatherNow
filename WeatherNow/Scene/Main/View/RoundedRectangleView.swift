//
//  RoundedRectangleView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct RoundedRectangleView: View {
    
    @ObservedObject var viewModel: RoundedRectangleViewModel
    @Binding var isExpanded: Bool
    
    var buttonTapped: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Weather information")
                    .fontWeight(.bold)
                Spacer()
                Button {
                    buttonTapped()
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
                    if let weather = viewModel.weather{
                        IconWithTextView(viewModel: IconWithTextViewModel(value: weather.current.feelslikeC, valueType: .temperature), isExpanded: $isExpanded)
                        IconWithTextView(viewModel: IconWithTextViewModel(value: weather.current.feelslikeC, valueType: .precipitation), isExpanded: $isExpanded)
                        IconWithTextView(viewModel: IconWithTextViewModel(value: weather.current.uv, valueType: .uv), isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    } else {
                        IconWithTextView(viewModel: IconWithTextViewModel(value: 0, valueType: .temperature), isExpanded: $isExpanded)
                        IconWithTextView(viewModel: IconWithTextViewModel(value: 0, valueType: .precipitation), isExpanded: $isExpanded)
                        IconWithTextView(viewModel: IconWithTextViewModel(value: 0, valueType: .uv), isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    }
                }
                Spacer(minLength: 12)
                VStack(alignment: .leading, spacing: 12) {
                    if let weather = viewModel.weather {
                        IconWithTextView(viewModel: IconWithTextViewModel(value: weather.current.windKph, valueType: .wind), isExpanded: $isExpanded)
                        IconWithTextView(viewModel: IconWithTextViewModel(value: CGFloat(weather.current.humidity), valueType: .humidity), isExpanded: $isExpanded)
                        IconWithTextView(viewModel: IconWithTextViewModel(value: weather.current.pressureMB, valueType: .pressure), isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    } else {
                        IconWithTextView(viewModel: IconWithTextViewModel(value: 0, valueType: .wind), isExpanded: $isExpanded)
                        IconWithTextView(viewModel: IconWithTextViewModel(value: 0, valueType: .humidity), isExpanded: $isExpanded)
                        IconWithTextView(viewModel: IconWithTextViewModel(value: 0, valueType: .pressure), isExpanded: $isExpanded)
                            .frame(height: isExpanded ? .none : .zero)
                            .opacity(isExpanded ? 1 : 0)
                    }
                }
            }
            .padding(.horizontal)
            Divider()
                .padding(.horizontal)
            
            if let days = viewModel.weather?.forecast.forecastday {
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
                                    .fill(viewModel.colors[index])
                            }.onTapGesture {
                                withAnimation(.spring()) {
                                    for colorIndex in 0..<viewModel.colors.count {
                                        viewModel.colors[colorIndex] = .gray.opacity(0.5)
                                    }
                                    viewModel.colors[index] = .blue
                                    viewModel.selectedDay = index
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
                if let hours = viewModel.weather?.forecast.forecastday[viewModel.selectedDay].hour {
                    HStack(spacing: 32) {
                        ForEach(hours.indices, id: \.self) { index in
                            HourlyTemperatureView(viewModel: HourlyTemperatureViewModel(hour: hours[index]))
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 28)
                } else {
                    HourlyTemperatureView(viewModel: HourlyTemperatureViewModel(hour: Hour(time: "2023-08-07 00:00", tempC: 0, tempF: 0, isDay: 0, condition: Condition(text: "", icon: "night", code: 1000), windMph: 0, windKph: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 0, feelslikeF: 0)))
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
        RoundedRectangleView(viewModel: RoundedRectangleViewModel(weather: WeatherModel(location: Location(name: "Baku", region: "Baku", country: "Azerbaijan", lat: 40, lon: 39, tzID: "", localtimeEpoch: 0, localtime: ""), current: Current(tempC: 24, tempF: 23, isDay: 0, condition: Condition(text: "Sunny", icon: "day", code: 1000), windMph: 19, windKph: 19, pressureMB: 19, pressureIn: 19, precipMm: 19, precipIn: 19, humidity: 12, cloud: 1, feelslikeC: 24, feelslikeF: 45, uv: 1), forecast: ForecastModel(forecastday: [Forecastday(date: "2023-08-07 00:00", day: Day(condition: Condition(text: "Sunny", icon: "day", code: 1000)), astro: Astro(sunrise: "", sunset: "", moonrise: "", moonset: ""), hour: [Hour(time: "", tempC: 24, tempF: 45, isDay: 0, condition: Condition(text: "", icon: "day", code: 1000), windMph: 12, windKph: 12, precipMm: 12, precipIn: 12, humidity: 12, cloud: 12, feelslikeC: 11, feelslikeF: 12)])]))), isExpanded: .constant(true), buttonTapped: MainView().toggleIsExpanded)
    }
}

//
//  RoundedRectangleView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct RoundedRectangleView: View {
    
    let weather: WeatherEntity?
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
                        SmallIconWithTextCell(value: weather.currentWeather.feelslikeC, valueType: .temperature, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: weather.currentWeather.precipIn, valueType: .precipitation, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: weather.currentWeather.uv, valueType: .uv, isExpanded: $isExpanded)
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
                        SmallIconWithTextCell(value: weather.currentWeather.windKph, valueType: .wind, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: CGFloat(weather.currentWeather.humidity), valueType: .humidity, isExpanded: $isExpanded)
                        SmallIconWithTextCell(value: weather.currentWeather.pressureMB, valueType: .pressure, isExpanded: $isExpanded)
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
            
            if let days = weather?.forecast {
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
                if let hours = weather?.forecast[selectedDay].hour {
                    HStack(spacing: 32) {
                        ForEach(hours.indices, id: \.self) { index in
                            HourlyTempView(hour: hours[index])
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 28)
                } else {
                    HourlyTempView(hour: .init(time: "", tempC: 0, condition: .init(text: "", icon: "", code: 0)))
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
        RoundedRectangleView(weather: .mock, isExpanded: .constant(true), handleButton: MainView().toggleIsExpanded)
    }
}

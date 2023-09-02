//
//  ContentView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 03.06.23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = MainViewModel()
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            viewModel.bgColor
                .ignoresSafeArea()
            VStack(spacing: 0) {
                locationIconCityName
                .padding(.bottom)
                    Spacer()
                HStack {
                    ZStack(alignment: .topTrailing) {
                        weatherIcon
                        
                        if !viewModel.isExpanded {
                            TextAnimatableValue(value: viewModel.tempC, unit: "°")
                                .fixedSize()
                                .foregroundColor(.white)
                                .font(.system(size: 88, weight: .heavy))
                                .offset(x: 30, y: -30)
                                .matchedGeometryEffect(id: "DegreText", in: animation)
                        }
                    }
                    if viewModel.isExpanded {
                        TextAnimatableValue(value: viewModel.tempC, unit: "°")
                            .fixedSize()
                            .foregroundColor(.white)
                            .font(.system(size: 44, weight: .heavy))
                            .matchedGeometryEffect(id: "DegreText", in: animation)
                        
                        statusOfDayAndDateView
                    }
                }
                Spacer()
                if !viewModel.isExpanded {
                    statusOfDayAndDateView
                }
                RoundedRectangleView(weather: viewModel.weather, isExpanded: $viewModel.isExpanded, handleButton: toggleIsExpanded)
                    .frame(maxWidth: 640)
                    .onTapGesture {
                        toggleIsExpanded()
                    }
            }
            .onChange(of: viewModel.weather?.current.tempC) { newValue in
                withAnimation(.easeInOut(duration: 1.5)) {
                    viewModel.tempC = viewModel.weather?.current.tempC ?? 0
                    viewModel.imageOffset = .zero
                }
                withAnimation(.easeInOut(duration: 2)) {
                    viewModel.bgColor = viewModel.bgColorFromData
                }
            }
        }
    }
    
    func toggleIsExpanded() {
        withAnimation(.spring()) {
            viewModel.isExpanded.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// MARK: - WeatherIcon
extension MainView {
    @ViewBuilder
    var weatherIcon: some View {
        Image(viewModel.imageName)
            .resizable()
            .scaledToFit()
            .padding(viewModel.isExpanded ? 0 : 16)
            .frame(maxWidth: viewModel.isExpanded ? 180 : 320,maxHeight: viewModel.isExpanded ? 180 : 320)
            .offset(x: viewModel.imageOffset.width, y: viewModel.imageOffset.height)
            .onTapGesture {
                withAnimation(.spring()) {
                    viewModel.isExpanded.toggle()
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.imageOffset.height = gesture.translation.height
                            viewModel.imageOffset.width = gesture.translation.width
                        }
                    })
                    .onEnded({ _ in
                        withAnimation(.easeOut(duration: 0.75)) {
                            viewModel.imageOffset = .zero
                        }
                    })
            )
    }
}

// MARK: - Location icon and city name
extension MainView {
    @ViewBuilder
    var locationIconCityName: some View {
        HStack(alignment: .center, spacing: 2) {
            Image("location")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            Text(viewModel.cityName)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
    }
}

// MARK: - StatusOfDayAndDateView
extension MainView {
    @ViewBuilder
    var statusOfDayAndDateView: some View {
        VStack(alignment: viewModel.isExpanded ? .leading : .center, spacing: 8) {
            Text(viewModel.conditionText)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text(Helpers.shared.getDate(dateString: viewModel.localtimeText, dateType: .weekDayMonth))
                .foregroundColor(.white)
        }
        .fixedSize()
        .opacity(viewModel.weather == nil ? 0 : 1)
        .padding(.horizontal)
        .matchedGeometryEffect(id: "StatusText", in: animation)
    }
}

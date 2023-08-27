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
                .padding(.bottom)
                
                    Spacer()
                HStack {
                    ZStack(alignment: .topTrailing) {
                        Image(viewModel.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(viewModel.isExpanded ? 0 : 16)
                            .frame(maxWidth: viewModel.isExpanded ? 180 : 320,maxHeight: viewModel.isExpanded ? 180 : 320)
                            .offset(x: viewModel.imageOffset.width, y: viewModel.imageOffset.height)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    toggleIsExpanded()
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
                        
                        if !viewModel.isExpanded {
                            TextAnimatableValue(value: viewModel.tempC, valueType: .temperature)
                                .fixedSize()
                                .foregroundColor(.white)
                                .font(.system(size: 88, weight: .heavy))
                                .offset(x: 30, y: -30)
                                .matchedGeometryEffect(id: "TemperatureText", in: animation)
                        }
                    }
                    if viewModel.isExpanded {
                        TextAnimatableValue(value: viewModel.tempC, valueType: .temperature)
                            .fixedSize()
                            .foregroundColor(.white)
                            .font(.system(size: 44, weight: .heavy))
                            .matchedGeometryEffect(id: "TemperatureText", in: animation)
                        
                        StatusOfDayView(viewModel: StatusOfDayViewModel(status: viewModel.conditionText, date: viewModel.localtimeText), isExpanded: $viewModel.isExpanded)
                            .fixedSize()
                            .opacity(viewModel.weather == nil ? 0 : 1)
                            .padding(.horizontal)
                            .matchedGeometryEffect(id: "StatusText", in: animation)
                    }
                }
                Spacer()
                if !viewModel.isExpanded {
                    StatusOfDayView(viewModel: StatusOfDayViewModel(status: viewModel.conditionText, date: viewModel.localtimeText), isExpanded: $viewModel.isExpanded)
                        .fixedSize()
                        .opacity(viewModel.weather == nil ? 0 : 1)
                        .matchedGeometryEffect(id: "StatusText", in: animation)
                }
                RoundedRectangleView(viewModel: RoundedRectangleViewModel(weather: viewModel.weather), isExpanded: $viewModel.isExpanded, buttonTapped: toggleIsExpanded)
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
                    viewModel.bgColor = viewModel.getBGColor
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

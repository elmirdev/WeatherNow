//
//  ContentView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 03.06.23.
//

import SwiftUI

struct MainView: View {
    @State private var bgColor = Color.black
    @State private var tempC: CGFloat = 0
    @State private var imageOffset = CGSize(width: 0, height: UIScreen.main.bounds.height)
    @State private var isExpanded = false
    
    @ObservedObject private var viewModel = MainViewModel()
    
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            bgColor
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
                            .padding(isExpanded ? 0 : 16)
                            .frame(maxWidth: isExpanded ? 180 : 320,maxHeight: isExpanded ? 180 : 320)
                            .offset(x: imageOffset.width, y: imageOffset.height)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    isExpanded.toggle()
                                }
                            }
                            .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            self.imageOffset.height = gesture.translation.height
                                            self.imageOffset.width = gesture.translation.width
                                        }
                                    })
                                    .onEnded({ _ in
                                        withAnimation(.easeOut(duration: 0.75)) {
                                            self.imageOffset = .zero
                                        }
                                    })
                            )
                        
                        if !isExpanded {
                            TextAnimatableValue(value: tempC, unitOfValue: .temperature)
                                .fixedSize()
                                .foregroundColor(.white)
                                .font(.system(size: 88, weight: .heavy))
                                .offset(x: 30, y: -30)
                                .matchedGeometryEffect(id: "DegreText", in: animation)
                        }
                    }
                    if isExpanded {
                        TextAnimatableValue(value: tempC, unitOfValue: .temperature)
                            .fixedSize()
                            .foregroundColor(.white)
                            .font(.system(size: 44, weight: .heavy))
                            .matchedGeometryEffect(id: "DegreText", in: animation)
                        
                        StatusOfDayAndDateView(status: viewModel.conditionText, date: viewModel.localtimeText, isExpanded: $isExpanded)
                            .fixedSize()
                            .opacity(viewModel.weather == nil ? 0 : 1)
                            .padding(.horizontal)
                            .matchedGeometryEffect(id: "StatusText", in: animation)
                    }
                }
                Spacer()
                if !isExpanded {
                    StatusOfDayAndDateView(status: viewModel.conditionText, date: viewModel.localtimeText, isExpanded: $isExpanded)
                        .fixedSize()
                        .opacity(viewModel.weather == nil ? 0 : 1)
                        .matchedGeometryEffect(id: "StatusText", in: animation)
                }
                RoundedRectangleView(weather: viewModel.weather, isExpanded: $isExpanded, handleButton: toggleIsExpanded)
                    .frame(maxWidth: 640)
                    .onTapGesture {
                        toggleIsExpanded()
                    }
            }
            .onChange(of: viewModel.weather?.current.tempC) { newValue in
                withAnimation(.easeInOut(duration: 1.5)) {
                    self.tempC = viewModel.weather?.current.tempC ?? 0
                    imageOffset = .zero
                }
                withAnimation(.easeInOut(duration: 2)) {
                    bgColor = viewModel.bgColor
                }
            }
        }
    }
    
    func toggleIsExpanded() {
        withAnimation(.spring()) {
            isExpanded.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

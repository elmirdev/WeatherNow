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
                
                if !isExpanded {
                    Spacer()
                }
                HStack {
                    ZStack(alignment: .topTrailing) {
                        Image(viewModel.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(maxWidth: isExpanded ? 120 : 320, maxHeight: isExpanded ? 120 : 320)
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
                            TextAnimatableValue(value: tempC, unit: "°")
                                .fixedSize()
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .font(.system(size: 88))
                                .offset(x: 30, y: -30)
                                .matchedGeometryEffect(id: "DegreText", in: animation)
                        }
                    }
                    if isExpanded {
                        TextAnimatableValue(value: tempC, unit: "°")
                            .fixedSize()
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(.system(size: 44))
                            .matchedGeometryEffect(id: "DegreText", in: animation)
                        
                        StatusOfDayAndDateView(status: viewModel.conditionText, date: viewModel.localtimeText, isExpanded: $isExpanded)
                            .fixedSize()
                            .opacity(viewModel.weather == nil ? 0 : 1)
                            .padding()
                            .matchedGeometryEffect(id: "StatusText", in: animation)
                        Spacer()
                    }
                }
                if !isExpanded {
                    Spacer()
                    StatusOfDayAndDateView(status: viewModel.conditionText, date: viewModel.localtimeText, isExpanded: $isExpanded)
                        .fixedSize()
                        .opacity(viewModel.weather == nil ? 0 : 1)
                        .matchedGeometryEffect(id: "StatusText", in: animation)
                }
                RoundedRectangleView(weather: viewModel.weather, isExpanded: $isExpanded)
                    .frame(maxWidth: 640)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
                if isExpanded {
                    Spacer()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

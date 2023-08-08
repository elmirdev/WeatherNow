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
    @State private var isZoomed = false

    @ObservedObject private var viewModel = MainViewModel()
    
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text((viewModel.weather?.location.name ?? "Loading.."))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                if !isZoomed {
                    Spacer()
                }
                HStack {
                    ZStack(alignment: .topTrailing) {
                            Image(viewModel.imageName)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(maxWidth: isZoomed ? 120 : 320, maxHeight: isZoomed ? 120 : 320)
                                .offset(x: imageOffset.width, y: imageOffset.height)
                                .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        withAnimation(.easeInOut(duration: 1)) {
                                            self.imageOffset.height = gesture.translation.height
                                            self.imageOffset.width = gesture.translation.width
                                        }
                                    })
                                    .onEnded({ _ in
                                        withAnimation(.easeOut(duration: 1)) {
                                            self.imageOffset = .zero
                                        }
                                    })
                                )

                        if !isZoomed {
                            TextAnimatableValue(value: tempC, unit: "°")
                                .fixedSize()
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .font(.system(size: 88))
                                .offset(x: 30, y: -30)
                                .matchedGeometryEffect(id: "DegreText", in: animation)
                        }
                    }
                    if isZoomed {
                        TextAnimatableValue(value: tempC, unit: "°")
                            .fixedSize()
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(.system(size: 44))
                            .matchedGeometryEffect(id: "DegreText", in: animation)
                        
                        StatusOfDayAndDateView(status: viewModel.weather?.current.condition.text ?? "Loading..", date: viewModel.weather?.location.localtime ?? "Loading..", isZoomed: $isZoomed)
                            .fixedSize()
                            .padding()
                            .matchedGeometryEffect(id: "StatusText", in: animation)
                        Spacer()
                    }
                }
                if !isZoomed {
                    Spacer()
                    StatusOfDayAndDateView(status: viewModel.weather?.current.condition.text ?? "Loading..", date: viewModel.weather?.location.localtime ?? "Loading..", isZoomed: $isZoomed)
                        .fixedSize()
                        .matchedGeometryEffect(id: "StatusText", in: animation)
                }
                RoundedRectangleView(weather: viewModel.weather, isZoomed: $isZoomed)
                    .frame(maxWidth: 640)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isZoomed.toggle()
                        }
                    }
                if isZoomed {
                    Spacer()
                }
            }
            .onChange(of: viewModel.weather?.current.tempC) { newValue in
                withAnimation(.easeInOut(duration: 2)) {
                    bgColor = viewModel.bgColor
                    self.tempC = viewModel.weather?.current.tempC ?? 0
                    imageOffset = .zero
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

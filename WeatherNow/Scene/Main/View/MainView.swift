//
//  ContentView.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 03.06.23.
//

import SwiftUI

struct MainView: View {
    
    @State var tempC: CGFloat = 0
    @ObservedObject var viewModel = MainViewModel()
    @State var imageOffset = CGSize(width: 0, height: UIScreen.main.bounds.height)
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.blue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text((viewModel.weather?.location.name ?? "") + " " + (viewModel.weather?.location.country ?? "-"))
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.top)
                ZStack(alignment: .topTrailing) {
                    Image("11")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 270, height: 270)
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

                    TextAnimatableValue(value: tempC)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 100))
                        .offset(x: 55, y: -30)
                }.padding()
                StatusOfDayAndDateView(status: viewModel.weather?.current.condition.text ?? "-", date: viewModel.weather?.location.localtime ?? "-")
                RoundedRectangleView(weather: viewModel.weather)
            }
        }.task {
            viewModel.getData {
                withAnimation(.easeInOut(duration: 2)) {
                    self.tempC = viewModel.weather?.current.tempC ?? 0
                    imageOffset = .zero
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init())
    }
}

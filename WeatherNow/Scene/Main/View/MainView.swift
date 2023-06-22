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
                        .frame(height: 350)
                    TextAnimatableValue(value: tempC)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 100))
                }
                StatusOfDayAndDateView(status: viewModel.weather?.current.condition.text ?? "-", date: viewModel.weather?.location.localtime ?? "-")
                RoundedRectangleView(weather: viewModel.weather)
            }
        }.task {
            viewModel.getData {
                withAnimation(.easeInOut(duration: 2)) {
                    self.tempC = viewModel.weather?.current.tempC ?? 0
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

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
                Text("Beylagan, Azerbaijan")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
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
                StatusOfDayAndDateView(status: "It's cloudy day", date: "Sunday, 4 Jun")
                RoundedRectangleView(weather: viewModel.weather)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init())
    }
}

//
//  TextAnimatableValue.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 05.06.23.
//

import Foundation
import SwiftUI

struct TextAnimatableValue: View, Animatable {
    var value: CGFloat
    var unit: String

    var animatableData: CGFloat {
        get { value }
        set {
            value = newValue
        }
    }
    
    var body: some View {
        Text("\(String(format: "%.0f", value))\(unit)")
    }
}

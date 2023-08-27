//
//  IconWithTextViewModel.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 28.08.23.
//

import Foundation

class IconWithTextViewModel: ObservableObject {
    let value: CGFloat
    let valueType: ValueType
    
    @Published var animatableValue: CGFloat = 0

    init(value: CGFloat, valueType: ValueType) {
        self.value = value
        self.valueType = valueType
    }
    
    var imageText: String {
        return valueType.imageText
    }
    
    var title: String {
        return valueType.title
    }
    
    var unit: String {
        return valueType.unit
    }
}

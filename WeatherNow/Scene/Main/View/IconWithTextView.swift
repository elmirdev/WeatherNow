//
//  SmallIconWithText.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct SmallIconWithTextCell: View {
    let value: CGFloat
    let valueType: ValueType
    @State private var animatableValue: CGFloat = 0
    @Binding var isExpanded: Bool
    @Namespace private var animation
    
    @State private var animatableValue: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.quaternary.opacity(0.25))
                .frame(height: isExpanded ? 96 : 48)
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 16) {
                    Image(valueType.imageText)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 24, maxHeight: 24)
                        .background {
                            Circle()
                                .fill(.quaternary.opacity(0.35))
                                .frame(width:32, height: 32)
                        }
                    if isExpanded {
                        VStack(alignment: .leading) {
                            Text(valueType.title)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .fixedSize()
                                .matchedGeometryEffect(id: "TitleText", in: animation)
                            TextAnimatableValue(value: animatableValue, unit: valueType.unit)
                                .font(.system(size: 14, weight: .bold))
                                .fixedSize()
                                .matchedGeometryEffect(id: "ValueText", in: animation)
                        }
                    }
                }
                if !isExpanded {
                    VStack(alignment: .leading) {
                        Text(valueType.title)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .fixedSize()
                            .matchedGeometryEffect(id: "TitleText", in: animation)
                        TextAnimatableValue(value: animatableValue, unit: valueType.unit)
                            .font(.system(size: 14, weight: .bold))
                            .fixedSize()
                            .matchedGeometryEffect(id: "ValueText", in: animation)
                    }
                }
            }
            .padding(.horizontal, 12)
            .onAppear {
                withAnimation(.easeInOut(duration: 2)) {
                    animatableValue = viewModel.value
                }
            }
        }
    }
}

struct SmallIconWithText_Previews: PreviewProvider {
    static var previews: some View {
        SmallIconWithTextCell(value: 16, valueType: .temperature, isExpanded: .constant(true))
    }
}

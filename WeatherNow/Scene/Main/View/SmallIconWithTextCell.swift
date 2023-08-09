//
//  SmallIconWithText.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct SmallIconWithTextCell: View {
    let imageText: String
    let title: String
    let value: CGFloat
    let unit: String
    @State private var animatableValue: CGFloat = 0
    @Binding var isExpanded: Bool
    @Namespace private var animation
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.quaternary.opacity(0.25))
                .frame(maxHeight: 96)
                .opacity(isExpanded ? 1 : 0)
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 16) {
                    Image(imageText)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .background {
                            Circle()
                                .fill(.quaternary.opacity(0.35))
                                .frame(width:32, height: 32)
                        }
                    if isExpanded {
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .fixedSize()
                                .matchedGeometryEffect(id: "TitleText", in: animation)
                            TextAnimatableValue(value: animatableValue, unit: unit)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .fixedSize()
                                .matchedGeometryEffect(id: "ValueText", in: animation)
                        }
                    }
                }
                if !isExpanded {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .fixedSize()
                            .matchedGeometryEffect(id: "TitleText", in: animation)
                        TextAnimatableValue(value: animatableValue, unit: unit)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .fixedSize()
                            .matchedGeometryEffect(id: "ValueText", in: animation)
                    }
                }
            }
            .padding(16)
            .onAppear {
                withAnimation(.easeInOut(duration: 2)) {
                    self.animatableValue = value
                }
            }
        }
    }
}

struct SmallIconWithText_Previews: PreviewProvider {
    static var previews: some View {
        SmallIconWithTextCell(imageText: "temperature", title: "Precipitation", value: 16, unit: "°", isExpanded: .constant(true))
    }
}

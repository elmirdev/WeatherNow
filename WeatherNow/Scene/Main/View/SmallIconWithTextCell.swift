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
    @Binding var isZoomed: Bool
    @Namespace private var animation
    
    var body: some View {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 16) {
                    Image(imageText)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .background {
                            Circle()
                                .fill(.quaternary.opacity(0.5))
                                .frame(width:32, height: 32)
                    }
                    if isZoomed {
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: "TitleText", in: animation)
                            TextAnimatableValue(value: animatableValue, unit: unit)
                                .font(.caption)
                                .fontWeight(.bold)
                                .matchedGeometryEffect(id: "ValueText", in: animation)
                        }
                    }
                }
                if !isZoomed {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: "TitleText", in: animation)
                        TextAnimatableValue(value: animatableValue, unit: unit)
                            .font(.caption)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "ValueText", in: animation)
                    }
                }
            }
            .padding(isZoomed ? 16 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 2)) {
                    self.animatableValue = value
                }
        }
    }
}

struct SmallIconWithText_Previews: PreviewProvider {
    static var previews: some View {
        SmallIconWithTextCell(imageText: "temperature", title: "Test", value: 16, unit: "°", isZoomed: .constant(false))
    }
}

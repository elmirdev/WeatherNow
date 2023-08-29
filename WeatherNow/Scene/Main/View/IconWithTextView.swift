//
//  SmallIconWithText.swift
//  WeatherNow
//
//  Created by ELMIR ISMAYILZADA on 06.06.23.
//

import SwiftUI

struct IconWithTextView: View {
    @ObservedObject var viewModel: IconWithTextViewModel
    @Binding var isExpanded: Bool
    @Namespace private var animation
    
    @State var animatableValue: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.quaternary.opacity(0.25))
                .frame(height: isExpanded ? 96 : 48)
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 16) {
                    Image(viewModel.imageText)
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
                            Text(viewModel.title)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .fixedSize()
                                .matchedGeometryEffect(id: "TitleText", in: animation)
                            TextAnimatableValue(value: animatableValue, valueType: viewModel.valueType)
                                .font(.system(size: 14, weight: .bold))
                                .fixedSize()
                                .matchedGeometryEffect(id: "ValueText", in: animation)
                        }
                    }
                }
                if !isExpanded {
                    VStack(alignment: .leading) {
                        Text(viewModel.title)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .fixedSize()
                            .matchedGeometryEffect(id: "TitleText", in: animation)
                        TextAnimatableValue(value: animatableValue, valueType: viewModel.valueType)
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
        IconWithTextView(viewModel: .init(value: 20, valueType: .humidity), isExpanded: .constant(true))
    }
}

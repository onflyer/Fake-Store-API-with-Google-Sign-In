//
//  CustomPicker.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/31/24.
//

import SwiftUI

struct CustomPicker: View {
    @Binding var pickedCategory: EndPointEnum
    var body: some View {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(EndPointEnum.allCases, id: \.self) { category in
                        Button(action: {
                            pickedCategory = category
                        }, label: {
                                Text(category.rawValue)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(height: 50)
                                    .background(Color(.gray).opacity(0.7))
                        })
                    
                }
                }

        }
    }
}

#Preview {
    CustomPicker(pickedCategory: .constant(.all))
}

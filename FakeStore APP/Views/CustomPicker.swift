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
                LazyHStack {
                    ForEach(EndPointEnum.allCases, id: \.self) { category in
                        Button(action: {
                            pickedCategory = category
                        }, label: {
                            Text(category.rawValue)
                            
                        })
                    
                }
                }

        }
    }
}

#Preview {
    CustomPicker(pickedCategory: .constant(.all))
}

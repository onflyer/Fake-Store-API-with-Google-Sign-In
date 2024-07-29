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
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(EndPointEnum.allCases, id: \.self) { category in
                        
                        Button(action: {
                            withAnimation {
                                pickedCategory = category
                            }
                        }, label: {
                            Text(category.rawValue)
                                .padding()
                                .frame(height: 50)
                                .background(pickedCategory == category ? Color.white : Color.clear)
                                .foregroundStyle(pickedCategory == category ? Color("darkblue") : Color.white)
                                .cornerRadius(pickedCategory == category ? 12 : 0)
                                
                        })
                        .containerRelativeFrame(.horizontal, count: 3, spacing: 0)
                        
                    }
                }
                .frame(height: 50)
                .padding(5)
                .background(Color("darkblue"))
               
        }
           
    }
}

#Preview {
    CustomPicker(pickedCategory: .constant(.All))
}

//
//  ContentView.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var session: SessionManager
    @State private var pickedCategory: EndPointEnum = .All
    @StateObject var viewmodel = HomeScreenViewModel(httpClient: HTTPClient())
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    init() {
      // Large Navigation Title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
   
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("darkblue").opacity(0.95).ignoresSafeArea()
                VStack {
                CustomPicker(pickedCategory: $pickedCategory)
                Spacer()
                    if viewmodel.isLoading {
                        ZStack {
                            Color("darkblue").opacity(0.95).ignoresSafeArea()
                                ProgressView()
                                .tint(Color.white)
                            
                            .foregroundStyle(.white)
                            
                        }
                        
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(viewmodel.products) { product in
                                    ZStack {
                                        Color.white
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                        VStack {
                                            CachedImage(url: product.image ) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                case .failure(_):
                                                    Image(systemName: "xmark")
                                                        .resizable()
                                                @unknown default:
                                                    EmptyView()
                                                }
                                                
                                            }
                                            .padding(.top)
                                            Text(product.title)
                                                .foregroundStyle(Color("darkblue"))
                                                .lineLimit(1)
                                                .padding(10)
                                            
                                        }
                                    }
                                    .frame(width: 180, height: 180)
                                    
                                    
                                    
                                }
                            }
                            
                        }
                    }
                   
                    
                        
                    
                    
                      
                    
                }
                .navigationTitle("Fake Store Platzi")
               
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            session.signOut()
                        }, label: {
                            Text("Log out")
                        })
                    }
            }
            }
            .task {
                await viewmodel.loadProducts(endpointURL: pickedCategory)
            }
            .onChange(of: pickedCategory) {
                Task {
                    await viewmodel.loadProducts(endpointURL: pickedCategory)
                }
            }
        }

    }
}

#Preview {
    HomeScreen()
        .environmentObject(SessionManager())
}

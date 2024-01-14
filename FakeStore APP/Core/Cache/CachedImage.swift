//
//  CachedImage.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 12/16/23.
//

import SwiftUI

struct CachedImage<Content: View>: View {
   
    
    @StateObject private var manager = CachedImageManager()
    let url: String
    let animation: Animation?
    let transition: AnyTransition?
    let content: (AsyncImagePhase) -> Content
   
    init(url: String, animation: Animation? = nil, transition: AnyTransition? = nil, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.animation = animation
        self.transition = transition
        self.content = content
    }
    
    var body: some View {
        ZStack {
            switch manager.currentState {
            case .loading:
               if let transition = transition {
                    content(.empty)
                    .transition(transition)
                } else {
                    content(.empty)
                }
                    
            case .success(let data):
                if let image = UIImage(data: data) {
                    if let transition = transition {
                        content(.success(Image(uiImage: image)))
                            .transition(transition)
                    } else {
                        content(.success(Image(uiImage: image)))
                    }
                    
                } else {
                    if let transition = transition {
                        content(.failure(CachedImageError.invalidData))
                            .transition(transition)
                    } else {
                        content(.failure(CachedImageError.invalidData))
                    }
                    
                    if let transition = transition {
                        content(.failure(CachedImageError.invalidData))
                            .transition(transition)
                    } else {
                        content(.failure(CachedImageError.invalidData))
                    }
                    
                }
            case .failed(let error):
                if let transition = transition {
                    content(.failure(error))
                        .transition(transition)
                } else {
                    content(.failure(error))
                }
                
            default:
                if let transition = transition {
                    content(.empty)
                        .transition(transition)
                } else {
                    content(.empty)
                }
                
            }
        }
        .animation(animation, value: manager.currentState)
        .task {
            await manager.loadImage(url)
        }
    }
}

//#Preview {
//    CachedImage(url: Movie.stubbedMovie.posterURLString) { phase in
//        switch phase {
//        case .empty:
//            ProgressView()
//        case .success(let image):
//            image
//                .resizable()
//            
//        case .failure(let error):
//            Image(systemName: "xmark")
//                .resizable()
//            
//        
//        @unknown default:
//            EmptyView()
//        }
//    }
//        
//}

extension CachedImage {
    enum CachedImageError: Error {
        case invalidData
    }
}

//
//  LodingView.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//

import Foundation
import SwiftUI
import Firebase

struct LoadingView: View {
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack{
            if show{
                Group{
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: show)
    }
}
//struct LodingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LodingView()
//    }
//}

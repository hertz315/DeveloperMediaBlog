//
//  MainView.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//

import SwiftUI
import Combine

struct MainView: View {
    
    var body: some View {
        // MARK: - 탭뷰 (포스트/프로필)
        
        TabView {
            Text("피드")
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Post's")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Profile")
                }
            
        }
        .tint(.black)
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

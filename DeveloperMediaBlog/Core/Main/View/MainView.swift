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
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(
                    Color.gray.opacity(0.05),
                    for: .tabBar)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Profile")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(
                    Color.gray.opacity(0.05),
                    for: .tabBar)
            
        }
        .accentColor(.black)
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

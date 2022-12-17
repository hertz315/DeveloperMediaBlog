//
//  DeveloperMediaBlogApp.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//

import SwiftUI
import Firebase

@main
struct DeveloperMediaBlogApp: App {
    
    // MARK: - 중요⭐️
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

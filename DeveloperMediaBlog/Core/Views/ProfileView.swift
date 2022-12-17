//
//  ProfileView.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileVM = ProfileVM()
    
    var body: some View {
        NavigationStack {
            VStack{
                if let myProfile = profileVM.myProfile {
                    ReusableProfileContent(user: myProfile)
                        .refreshable {
                            // MARK: Refresh User Data
                            profileVM.myProfile = nil
                            await profileVM.fetchUserData()
                        }
                }else{
                    ProgressView()
                }
            }
            .navigationTitle("유저 프로필")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        // MARK: - 2개의 액션 (로그아웃 / 유저삭제)
                        Button("로그아웃") {
                            profileVM.logOutUser()
                        }
                        
                        Button("계정삭제") {
                            profileVM.deleteAccount()
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .tint(.black)
                            .scaleEffect(0.8)
                    }
                    
                }
            }
        }
        .overlay(
            LoadingView(show: $profileVM.isLoading)
        )
        .alert(profileVM.errorMessage, isPresented: $profileVM.showError) {
            
        }
        .task {
            // This Modifer is like onAppear
            // So Fetching for the First Time Only
            if profileVM.myProfile != nil{return}
            // MARK: Initial Fetch
            await profileVM.fetchUserData()
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

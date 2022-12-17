//
//  RegisterVM.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import SwiftUI
import Combine

final class RegisterVM: ObservableObject {
    // MARK: User Details
    @Published var emailID: String = ""
    @Published var password: String = ""
    @Published var userName: String = ""
    @Published var userBio: String = ""
    @Published var userBioLink: String = ""
    @Published var userProfilePicData: Data?
    // MARK: View Properties
    @Environment(\.dismiss) var dismiss
    @Published var showImagePicker: Bool = false
    @Published var photoItem: PhotosPickerItem?
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    // MARK: UserDefaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    func selectedPhotoItem() {
        Task{
            do{
                guard let photoItem = photoItem else { return }
                guard let imageData = try await photoItem.loadTransferable(type: Data.self) else{return}
                // MARK: UI Must Be Updated on Main Thread
                await MainActor.run(body: {
                    userProfilePicData = imageData
                })
                
            }catch{}
        }
    }
    
    func registerUser(){
        isLoading = true
//        closeKeyboard()
        Task{
            do{
                // Step 1: Creating Firebase Account
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                // Step 2: Uploading Profile Photo Into Firebase Storage
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                guard let imageData = userProfilePicData else{return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                // Step 3: Downloading Photo URL
                let downloadURL = try await storageRef.downloadURL()
                // Step 4: Creating a User Firestore Object
                let user = User(username: userName, userBio: userBio, userBioLink: userBioLink, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL)
                // Step 5: Saving User Doc into Firestore Database
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: { [self] error in
                    if error == nil{
                        // MARK: Print Saved Successfully
                        print("Saved Successfully")
                        self.userNameStored = userName
                        self.userUID = userUID
                        self.profileURL = downloadURL
                        self.logStatus = true
                    }
                })
            }catch{
                // MARK: Deleting Created Account In Case of Failure
                try await Auth.auth().currentUser?.delete()
                await setError(error)
            }
        }
    }
    
    // MARK: Displaying Errors VIA Alert
    func setError(_ error: Error)async{
        // MARK: UI Must be Updated on Main Thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }


}

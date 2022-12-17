//
//  User.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct User: Identifiable,Codable {
    @DocumentID var id: String?
    var username: String?
    var userBio: String?
    var userBioLink: String?
    var userUID: String?
    var userEmail: String?
    var userProfileURL: URL?
    
    enum CodingKeys: CodingKey {
        case id
        case username
        case userBio
        case userBioLink
        case userUID
        case userEmail
        case userProfileURL
    }
}

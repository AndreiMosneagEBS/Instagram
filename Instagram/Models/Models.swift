//
//  Models.swift
//  Instagram
//
//  Created by Andrei Mosneag on 13.06.2022.
//

import Foundation

enum Gender {
    case Male, Female, Other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let count: UserCount
    let joinDate: Date
}

struct UserCount{
    let followers: Int
    let following: Int
    let post: Int
    
}
public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
    
}

/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL   // either video url of full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
    let owner: User
}
struct PostLike {
    let username: String
    let commentIdentifier: String
    
}

struct CommentLike {
    let username: String
    let postIdentifier: String
    
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
    
}


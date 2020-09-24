//
//  Response.swift
//  AlamofireDemo
//
//  Created by Milan Chalishajarwala on 9/7/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import Foundation

struct Response: Decodable{
    var items: [User]
}

struct User: Decodable{
    var id: Int
    var login: String
    var avatar_url: String
    var repos_url: String
    var url: String
}

struct Repo: Decodable{
    var id: Int
    var name: String
    var full_name: String
    var `private`: Bool
}


struct Profile: Decodable{
    var login: String?
    var avatar_url:String?
    var repos_url: String?
    var name: String?
    var location: String?
    var bio: String?
    var public_repos: Int?
    var blog: String?
    var email: String?
}
